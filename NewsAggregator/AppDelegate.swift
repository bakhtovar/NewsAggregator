//
//  AppDelegate.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 17/06/21.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
//        if Auth.auth().currentUser == nil {
//            self.show()
//        }
    
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                self.show()
                print("not logined")
            }
        }
        return true
    }
    func show() {
        let storyobard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyobard.instantiateViewController(identifier: "signin") as! SignInVC
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
        
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

