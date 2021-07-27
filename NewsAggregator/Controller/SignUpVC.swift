//
//  SignUpVC.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 13/07/21.
//

import UIKit
import Firebase

class SignUpVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var signupLabel: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var nameValue: UITextField!
    @IBOutlet weak var emailValue: UITextField!
    @IBOutlet weak var passwordValue: UITextField!
    @IBOutlet weak var registerText: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerText.layer.cornerRadius = 15
        nameValue.delegate = self
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
    
    @IBAction func registerButton(_ sender: Any) {
        signUp()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Fill out the fields.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func signUp (){
        
        let name = nameValue.text
        let password = passwordValue.text
        let email = emailValue.text
        
        if (!name!.isEmpty && !password!.isEmpty && !email!.isEmpty) {
            Auth.auth().createUser(withEmail: email ?? "", password: password ?? "") { (authResult, error) in
                if let e = error {
                    print(e.localizedDescription)
                    let alert = Service.createAlertController(title: "Error", message: e.localizedDescription)
                    self.present(alert, animated: true,completion: nil)
                } else {
                    if let res = authResult {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(identifier: "main")
                        vc.modalPresentationStyle = .overFullScreen
                        self.present(vc, animated: true)
                        
                        let ref  = Database.database().reference().child("users")
                        ref.child(res.user.uid).updateChildValues(["name" : name ?? "", "email": email ?? ""])
                        
                    }
                }
            }
        }
        else {
            showAlert()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

