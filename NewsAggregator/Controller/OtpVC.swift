//
//  OtpVC.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 30/07/21.
//

import UIKit

class OtpVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textOTP1: UITextField!
    @IBOutlet weak var textOTP2: UITextField!
    @IBOutlet weak var textOTP3: UITextField!
    @IBOutlet weak var textOTP4: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        textOTP1.backgroundColor = UIColor.clear
        textOTP2.backgroundColor = UIColor.clear
        textOTP3.backgroundColor = UIColor.clear
        textOTP4.backgroundColor = UIColor.clear
        addBottomBorderTo(textField: textOTP1)
        addBottomBorderTo(textField: textOTP2)
        addBottomBorderTo(textField: textOTP3)
        addBottomBorderTo(textField: textOTP4)
        
        textOTP1.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField.text!.count < 1) && (string.count > 0) {
            if textField == textOTP1 {
                textOTP2.becomeFirstResponder()
            }
            
            if textField == textOTP2 {
                textOTP2.becomeFirstResponder()
            }
            
            if textField == textOTP3 {
                textOTP4.becomeFirstResponder()
            }
            
            if textField == textOTP4 {
                textOTP4.resignFirstResponder()
            }
            
            textField.text = string
            return false
        } else if  ((textField.text!.count) >= 1) && (string.count == 0) {
            if textField == textOTP2 {
                textOTP1.becomeFirstResponder()
            }
            if textField == textOTP3 {
                textOTP2.becomeFirstResponder()
            }
            if textField == textOTP4 {
                textOTP3.becomeFirstResponder()
            }
            if textField == textOTP1 {
                textOTP1.becomeFirstResponder()
            }
            textField.text = ""
            return false
        } else if ((textField.text!.count) >= 1) {
            textField.text = string
            return false
        }
            //else  if ((textField.text!.count) >= 1) && (string.count == 0) {
//            if textField == textOTP2 {
//            textOTP1
//        }
//        }
        return true
    }
    func addBottomBorderTo(textField: UITextField) {
        let layer = CALayer()
        layer.backgroundColor = UIColor.gray.cgColor
        layer.frame = CGRect(x: 0.0, y: textField.frame.size.height - 2.0, width: textField.frame.size.width , height: 2.0)
        textField.layer.addSublayer(layer)
        
        
        
    }
    

 
}
