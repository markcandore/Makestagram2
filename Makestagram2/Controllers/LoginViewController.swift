//
//  LoginViewController.swift
//  Makestagram2
//
//  Created by Mark Wang on 6/29/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseAuthUI
import FirebaseDatabase
import FirebaseFacebookAuthUI
import FirebaseGoogleAuthUI

typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController{
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let authUI = FUIAuth.defaultAuthUI()
            else{ return }
        
        authUI.delegate = self
        
        // configure Auth UI for Facebook and Google login
        let providers: [FUIAuthProvider] = [FUIFacebookAuth(), FUIGoogleAuth()]
        authUI.providers = providers
        
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        if let error = error {
            assertionFailure("Error signing in \(error.localizedDescription)")
            
        }
        
        guard let user = user
            else { return }
        
        let userRef = Database.database().reference().child("users").child(user.uid)
        
        
        userRef.observeSingleEvent(of: .value, with: {[unowned self] (snapshot) in
            if let user = User(snapshot: snapshot) {
                User.setCurrent(user)
                
                let storyboard = UIStoryboard(name: "Main", bundle: .main)
                
                if let initialViewController = storyboard.instantiateInitialViewController(){
                    self.view.window?.rootViewController = initialViewController
                    //self.view.window?.makeKeyAndVisible()
                }
            } else {
                self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
            }
//
            //made irrelevant with UserService
//                if let user = User(snapshot: snapshot){
//                    print("Welcome back, \(user.username)")
//                } else{
//                    self.performSegue(withIdentifier: "toCreateUsername", sender: self)
//                }
        })
    
        UserService.show(forUID: user.uid) { (user) in
            if let user = user{
                User.setCurrent(user)
                
                let initialViewController = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
                
//                let storyboard = UIStoryboard(name: "Main", bundle: .main)
//                
//                if let initialViewController = storyboard.instantiateInitialViewController(){
//                    self.view.window?.rootViewController = initialViewController
//                    self.view.window?.makeKeyAndVisible()
            } else {
                self.performSegue(withIdentifier: "toCreateUsername", sender: self)
            }
            
        }
    }
}
