//
//  OTPViewController.swift
//  Aisle_Test
//
//  Created by Ayush Kumar Singh on 22/08/23.
//

import UIKit

class OTPViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var otpTxt: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var resendBtn: UIButton!
    
    var countdownTimer: Timer?
    var remainingTime = 60
    let viewModelObject = viewModel()
    var enteredPhoneNumber : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        
        // Do any additional setup after loading the view.
    }
    
    private func startTimer() {
            self.countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if remainingTime > 0 {
                remainingTime -= 1
                timerLabel.text = String(format: "%02d:%02d", remainingTime / 60, remainingTime % 60)
            } else {
                countdownTimer?.invalidate()
                resendBtn.isHidden = false
            }
    }
    
    @IBAction func pencilBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueBtnTapped(_ sender: Any) {
        
        guard let otp = otpTxt.text else {
            return
        }
        
        viewModelObject.verifyOTPPostRequest(phoneNumber: enteredPhoneNumber!, OTP: otp) { [weak self] token in
            guard let self = self else {
                return
            }
            if let token = token {
                DispatchQueue.main.async {
                    self.navigateToNotesScreen(authToken: token)
                }
            } else {
                DispatchQueue.main.async {
                    self.inavlidOTPAlert()
                }
            }
        }
        
    }
    
    @IBAction func resendBtnTapped(_ sender: Any) {
        remainingTime = 60
        startTimer()
        resendBtn.isHidden = true
    }
    
    private func navigateToNotesScreen(authToken: String) {
        guard let notesVC = self.storyboard?.instantiateViewController(withIdentifier: "NotesViewController") as? NotesViewController else { return }
        notesVC.authToken = authToken
        self.navigationController?.pushViewController(notesVC, animated: true)
    }
    
    private func inavlidOTPAlert() {
        let alert = UIAlertController(title: "Invalid OTP", message: "Please enter correct OTP", preferredStyle: .alert)
        let OKaction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(OKaction)
        present(alert, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
