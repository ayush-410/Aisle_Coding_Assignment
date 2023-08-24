//
//  NotesViewController.swift
//  Aisle_Test
//
//  Created by Ayush Kumar Singh on 23/08/23.
//

import UIKit

class NotesViewController: UIViewController {
    
    var authToken: String?
    let viewModelObject = viewModel()
    
    @IBOutlet weak var notesBtn: UITabBarItem!
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCustomCells()
        configureNotesBtn()
        // Do any additional setup after loading the view.
    }
    
    func configureNotesBtn(){
        if let view = notesBtn.value(forKey: "view") as? UIView {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(notesBtnTapped))
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func notesBtnTapped() {
        // Notes API called with token as header
        viewModelObject.notesGetRequest(token: authToken!) { response in
            debugPrint(response)
        }
    }
    
    func registerCustomCells() {
        
        tableview.register(UINib(nibName: "NotesHeadingTableViewCell", bundle: nil), forCellReuseIdentifier: "NotesHeadingTableViewCell")
        tableview.register(UINib(nibName: "NotesMainImageTableViewCell", bundle: nil), forCellReuseIdentifier: "NotesMainImageTableViewCell")
        tableview.register(UINib(nibName: "UpgradePremiumTableViewCell", bundle: nil), forCellReuseIdentifier: "UpgradePremiumTableViewCell")
        tableview.register(UINib(nibName: "BlurredImageTableViewCell", bundle: nil), forCellReuseIdentifier: "BlurredImageTableViewCell")
        
    }
    
    
    

}

extension NotesViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableview.dequeueReusableCell(withIdentifier: "NotesHeadingTableViewCell", for: indexPath) as! NotesHeadingTableViewCell
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableview.dequeueReusableCell(withIdentifier: "NotesMainImageTableViewCell", for: indexPath) as! NotesMainImageTableViewCell
            return cell
        } else if indexPath.row == 2 {
            let cell = tableview.dequeueReusableCell(withIdentifier: "UpgradePremiumTableViewCell", for: indexPath) as! UpgradePremiumTableViewCell
            return cell
        } else if indexPath.row == 3 {
            let cell = tableview.dequeueReusableCell(withIdentifier: "BlurredImageTableViewCell", for: indexPath) as! BlurredImageTableViewCell
            return cell
        }
        return UITableViewCell()
    }
    
}
