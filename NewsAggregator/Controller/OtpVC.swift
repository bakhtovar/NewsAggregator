//
//  OtpVC.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 30/07/21.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import Firebase

class OtpVC: UIViewController, UITextFieldDelegate {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var textOTP1: UITextField!
    @IBOutlet weak var textOTP2: UITextField!
    @IBOutlet weak var textOTP3: UITextField!
    @IBOutlet weak var textOTP4: UITextField!
    @IBOutlet weak var textOTP5: UITextField!
    @IBOutlet weak var textOTP6: UITextField!
    @IBOutlet weak var loginOTP: UIButton!
    
    //MARK:- VARIABLES
    var emailLabel: String?
    var passwordLabel: String?
    var phoneLabel : String?
    var code : String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureOTP()
    }
   
    func configureOTP(){
        loginOTP.layer.cornerRadius = 10
        textOTP1.backgroundColor = UIColor.clear
        textOTP2.backgroundColor = UIColor.clear
        textOTP3.backgroundColor = UIColor.clear
        textOTP4.backgroundColor = UIColor.clear
        textOTP5.backgroundColor = UIColor.clear
        textOTP6.backgroundColor = UIColor.clear
        
        
        addBottomBorderTo(textField: textOTP1)
        addBottomBorderTo(textField: textOTP2)
        addBottomBorderTo(textField: textOTP3)
        addBottomBorderTo(textField: textOTP4)
        addBottomBorderTo(textField: textOTP5)
        addBottomBorderTo(textField: textOTP6)
        
        textOTP1.delegate = self
        textOTP2.delegate = self
        textOTP3.delegate = self
        textOTP4.delegate = self
        textOTP5.delegate = self
        textOTP5.delegate = self
        

        textOTP1.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textOTP2.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textOTP3.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textOTP4.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textOTP5.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textOTP6.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }
   

    // MARK:- MOVING COURSOR AROUND OTP
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        if  text?.count == 1 {
            switch textField{
            case textOTP1:
                textOTP2.becomeFirstResponder()
            case textOTP2:
                textOTP3.becomeFirstResponder()
            case textOTP3:
                textOTP4.becomeFirstResponder()
            case textOTP4:
                textOTP5.becomeFirstResponder()
            case textOTP5:
                textOTP6.becomeFirstResponder()
            case textOTP6:
                textOTP6.resignFirstResponder()
            default:
                break
            }
        } else if text!.isEmpty  {
            switch textField{
            case textOTP6:
                textOTP5.becomeFirstResponder()
            case textOTP5:
                textOTP4.becomeFirstResponder()
            case textOTP4:
                textOTP3.becomeFirstResponder()
            case textOTP3:
                textOTP2.becomeFirstResponder()
            case textOTP2:
                textOTP1.becomeFirstResponder()
            default:
                break
            }
        }
        else{

        }
    }
    
    //MARK:- BOTTOM BORDER FOR OTP
    func addBottomBorderTo(textField: UITextField) {
        let layer = CALayer()
        layer.backgroundColor = UIColor.gray.cgColor
        layer.frame = CGRect(x: 0.0, y: textField.frame.size.height - 2.0, width: textField.frame.size.width , height: 2.0)
        textField.layer.addSublayer(layer)
    }
                
    
    //MARK:- VERIFYING OTP
    @IBAction func loginButton(_ sender: UIButton) {
        let str = textOTP1.text! + textOTP2.text! + textOTP3.text! + textOTP4.text!
        code = str + textOTP5.text! + textOTP6.text!
        guard let otpCode = code else { return }
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else { return }
        let credential: PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: otpCode)
        print(verificationID)
        
        print(otpCode)
        let number = phoneLabel
        if code != nil {
            Auth.auth().signIn(with: credential) { (success, error) in
                if (success != nil){
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(identifier: "main")
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true)
                    
                    let ref  = Database.database().reference().child("users")
                    ref.child(success!.user.uid).setValue([ "number": number ?? ""])
                } else {
                    let alert = Service.createAlertController(title: "Error", message: error!.localizedDescription)
                    self.present(alert, animated: true,completion: nil)
                }
            }
        }
       
        }
    }
