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
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loginText.layer.cornerRadius = 20
        signupText.layer.cornerRadius = 5
        navigationItem.hidesBackButton = true
        emailValue.delegate = self
        passwordValue.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 50
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
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
                    let alert = Service.createAlertController(title: "Error", message: e.localizedDescription)
                    self!.present(alert, animated: true,completion: nil)
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
