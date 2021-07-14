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
    
    
    
  //  var ref: DatabaseReference!
   var ref = Database.database().reference(fromURL: "news-acae1-default-rtdb.firebaseio.com/")
    var currentName : String?
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
    
        avatarImage.image = UIImage.gif(name: "avatar")
        
        
//        if let user = Auth.auth().currentUser {
//
//            //userName.text = "Hi, \(user.displayName)"
//
//
//        if let user = Auth.auth().currentUser {
//           userName.text = user.displayName
//
//        } else {
//          print("No Current User")
//        }
//        print(userName.text)
    
        loadUserData()
     
    }
    
    func loadUserData() {
        guard let uid  = Auth.auth().currentUser?.uid else {
            return
        }
        
        Database.database().reference().child("users").child(uid).child("name").observeSingleEvent(of: .value) { (snapshot) in
            guard let name = snapshot.value as? String else { return }
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
            let vc = storyboard.instantiateViewController(withIdentifier: "signin") as! SignInVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
