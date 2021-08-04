//
//  AccountVC.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 13/07/21.
//

import UIKit
import Firebase
import SwiftGifOrigin


class AccountVC: UIViewController {
    
  //MARK: -  REFERING TO DATABASE
   var ref = Database.database().reference(fromURL: "news-acae1-default-rtdb.firebaseio.com/")
    var currentName : String?
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        avatarImage.image = UIImage.gif(name: "avatar")
        loadUserData()
     
    }
    
    func loadUserData() {
        guard let uid  = Auth.auth().currentUser?.uid else {
            return
        }
        Database.database().reference().child("users").child(uid).child("name").observeSingleEvent(of: .value) { (snapshot) in
            guard let name = snapshot.value as? String else { return }
         // guard let number
            self.userName.text = "Hi, \(name)"
            UIView.animate(withDuration: 0.5) {
                self.userName.alpha = 1
            }
        }
    }

    
    @IBAction func logOutPressed(_ sender: Any) {
        tabBarController?.tabBar.isHidden = true
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }    
}
