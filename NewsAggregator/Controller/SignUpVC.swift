//
//  SignUpVC.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 13/07/21.
//

import UIKit
import Firebase

class SignUpVC: UIViewController, UITextFieldDelegate {
    
    

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameValue: UITextField!
    @IBOutlet weak var emailValue: UITextField!
    @IBOutlet weak var passwordValue: UITextField!
    @IBOutlet weak var registerText: UIButton!
    @IBOutlet weak var numberValue: UITextField!
    
    var textFieldRealYPosition: CGFloat = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerText.layer.cornerRadius = 15
        nameValue.delegate = self
        emailValue.delegate = self
        passwordValue.delegate = self
        numberValue.delegate = self
        self.hideKeyboardWhenTappedAround()
    }

    @IBAction func registerButton(_ sender: Any) {
        //self.performSegue(withIdentifier: "goNumber", sender: nil)
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
//                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                        let vc = storyboard.instantiateViewController(identifier: "NumberAuthVC") as! NumberAuthVC
//                        print(vc)
//                        self.present(vc, animated: true)

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

