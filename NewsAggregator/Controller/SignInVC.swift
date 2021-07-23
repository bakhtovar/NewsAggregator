//
//  SignUpVC.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 13/07/21.
//

import UIKit
import Firebase

//import IQKeyboardManager

class SignInVC: UIViewController, UITextFieldDelegate {
    
    //var window : UIWindow?
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var passwordText: UILabel!
    @IBOutlet weak var emailValue: UITextField!
    @IBOutlet weak var passwordValue: UITextField!
    @IBOutlet weak var loginText: UIButton!
    @IBOutlet weak var signupText: UIButton!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loginText.layer.cornerRadius = 20
        signupText.layer.cornerRadius = 5
        navigationItem.hidesBackButton = true
        emailValue.delegate = self
        passwordValue.delegate = self
        
   
        
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        signIn()
    }
    
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Fill out the fields.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func signIn() {
        if let password = passwordValue.text, let email = emailValue.text{
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                
                if let e = error {
                    print(e)
                } else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(identifier: "main")
                    vc.modalPresentationStyle = .overFullScreen
                    self!.present(vc, animated: true)
                }
                
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
