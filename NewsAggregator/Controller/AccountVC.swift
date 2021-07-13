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
    
    @IBOutlet weak var avatarImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
    
        avatarImage.image = UIImage.gif(name: "avatar")
        
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        
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
