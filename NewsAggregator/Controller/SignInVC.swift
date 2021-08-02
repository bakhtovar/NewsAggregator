//
//  SignUpVC.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 13/07/21.
//

import UIKit
import Firebase

class SignInVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var passwordText: UILabel!
    @IBOutlet weak var emailValue: UITextField!
    @IBOutlet weak var passwordValue: UITextField!
    @IBOutlet weak var loginText: UIButton!
    @IBOutlet weak var signupText: UIButton!
    @IBOutlet weak var phoneValue: UITextField!
    @IBOutlet weak var phoneLabel: UILabel!
    
   
    let userDefault = UserDefaults.standard
    override func viewDidLoad() {
               
        super.viewDidLoad()
        
        loginText.layer.cornerRadius = 20
        signupText.layer.cornerRadius = 5
        phoneLabel.layer.cornerRadius = 5
        
        emailValue.delegate = self
        passwordValue.delegate = self
        phoneValue.delegate = self
        
        self.hideKeyboardWhenTappedAround()
    }
    
    //MARK: - HIDE NAV BAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        signIn()
       
    }
    
    
    @IBAction func signUpButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(identifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Fill out the fields.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func signIn() {
        
        
        guard let phone = phoneValue.text else {
            return
        }
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { verificationID, error in
            if let error = error {
            let alert = Service.createAlertController(title: "Error", message: error.localizedDescription)
            self.present(alert, animated: true, completion: nil)
              } else {
                guard let verifuID = verificationID else {
                    return
                }
                
                self.userDefault.set(verifuID, forKey: "authVerificationID")
            
              }
            
          }

     
        if (!emailValue.text!.isEmpty && !passwordValue.text!.isEmpty && !phoneValue.text!.isEmpty) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "OtpVC") as! OtpVC

            vc.emailLabel = self.emailValue.text
            vc.passwordLabel = self.passwordValue.text
            vc.phoneLabel = self.phoneValue.text
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let alert = Service.createAlertController(title: "Error", message: "Fill out the fields")
            self.present(alert, animated: true,completion: nil)
            
        }

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
