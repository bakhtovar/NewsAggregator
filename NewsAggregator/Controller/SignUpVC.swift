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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        self.hideKeyboardWhenTappedAround()
    }
    var isExpand: Bool = false
    

//    @objc func keyboardWillShow(notification: Notification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//                if view.frame.origin.y == 0 {
//                    self.view.frame.origin.y -= keyboardSize.height
//                }
//            }
//
//        if !isExpand  {
//            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 250)
//            isExpand = true
//        }
//
//    }

//    @objc func keyboardWillHide(notification: Notification) {
//        if isExpand  {
//            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height - 250)
//            isExpand = false
//        }
//
//        if self.view.frame.origin.y != 0 {
//                self.view.frame.origin.y = 0
//            }
//
//
//    }
//

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification: NSNotification) {

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        
        if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
    }
    
//    @objc func keyboardWillShow(notification:NSNotification) {
//        guard let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {
//            return
//        }
//        let keyboardFrame = view.convert(keyboardFrameValue.cgRectValue, from: nil)
//        scrollView.contentOffset = CGPoint(x:0, y:keyboardFrame.size.height + 50)
//    }
//
//    @objc func keyboardWillHide(notification:NSNotification) {
//        scrollView.contentOffset = .zero
//    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
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

