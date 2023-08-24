//
//  ViewController.swift
//  Aisle_Test
//
//  Created by Ayush Kumar Singh on 22/08/23.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModelObject = viewModel()

    @IBOutlet weak var countryCodeTxt: UITextField!
    @IBOutlet weak var phoneNumberTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func continueBtnTapped(_ sender: Any) {
        
        guard let countrycode = countryCodeTxt.text, let phoneNumber = phoneNumberTxt.text else {
            return
        }
        
        // concatenating country code and phone number
        let enteredPhoneNumber = countrycode + phoneNumber
        
        // API Call with entered phone number
        viewModelObject.phoneNumberPostRequest(phoneNumber: enteredPhoneNumber) { [weak self] status in
            guard let self = self else {
                return
            }
            
            if status {
                DispatchQueue.main.async {
                    self.navigateToOTPScreen(phoneNumber: enteredPhoneNumber)
                }
                
            } else {
                DispatchQueue.main.async {
                    self.inavlidPhoneNumberAlert()
                }
            }
        }
    }
    
    private func navigateToOTPScreen(phoneNumber: String) {
        guard let otpVC = self.storyboard?.instantiateViewController(identifier: "OTPViewController") as? OTPViewController else {
            return
        }
        otpVC.enteredPhoneNumber = phoneNumber
        self.navigationController?.pushViewController(otpVC, animated: true)
    }
    
    private func inavlidPhoneNumberAlert() {
        let alert = UIAlertController(title: "Invalid Phone Number", message: "Please enter correct phone number ", preferredStyle: .alert)
        let OKaction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(OKaction)
        present(alert, animated: true)
    }
}

