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
        
        print(navigationController)
        print("ffff")
        //navigationItem.hidesBackButton = true
        emailValue.delegate = self
        passwordValue.delegate = self

        self.hideKeyboardWhenTappedAround()
    }
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
//        self.performSegue(withIdentifier: "SignUp", sender: nil)
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "signup") as? SignUpVC
//        self.navigationController?.pushViewController(vc!, animated: true)
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signup") as! SignUpVC
//        self.show(vc, sender: nil)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(identifier: "SignUpVC") as! SignUpVC
        
        self.show(vc, sender: nil)
        
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
