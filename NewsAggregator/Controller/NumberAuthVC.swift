//
//  NumberAuthVC.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 04/08/21.
//

import UIKit
import Firebase
import FirebaseAuth

class NumberAuthVC: UIViewController, UITextFieldDelegate {

    //MARK:- IB OUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberLabel: UITextField!
    @IBOutlet weak var buttonText: UIButton!
    
    
    let userDefault = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    func configureItems(){
        numberLabel.layer.cornerRadius = 20
        buttonText.layer.cornerRadius = 20
        numberLabel.delegate = self
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        signIn()
    }
    
    
    //MARK:- SENDING PHONE NUMBER
    func signIn() {
        guard let phone = numberLabel.text else {
            return
        }
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { verificationID, error in
            if let error = error {
            let alert = Service.createAlertController(title: "Error", message: error.localizedDescription)
            self.present(alert, animated: true, completion: nil)
              }
                self.userDefault.set(verificationID, forKey: "authVerificationID")
        }
     
        if (!numberLabel.text!.isEmpty) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "OtpVC") as! OtpVC
            vc.phoneLabel = self.numberLabel.text
            self.navigationController?.pushViewController(vc, animated: true)
           
            
        } else {
            let alert = Service.createAlertController(title: "Error", message: "Fill out the fields")
            self.present(alert, animated: true,completion: nil)
            
        }

    }
    

}
