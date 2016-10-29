//
//  ViewController.swift
//  SocialLogin
//
//  Created by Dante Solorio on 10/28/16.
//  Copyright © 2016 Dante Solorio. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fbLoginButton = FBSDKLoginButton()
        
        view.addSubview(fbLoginButton)
        fbLoginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        fbLoginButton.delegate = self
        fbLoginButton.readPermissions = ["email", "public_profile"]
        
        // Add custom fb login button
        let customFbLoginButton = UIButton(type: .system)
        customFbLoginButton.backgroundColor = .blue
        customFbLoginButton.setTitle("FB Login", for: .normal)
        customFbLoginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        customFbLoginButton.setTitleColor(.white, for: .normal)
        customFbLoginButton.frame = CGRect(x: 16, y: 116, width: view.frame.width - 32, height: 50)
        customFbLoginButton.addTarget(self, action: #selector(handleCustomLoginAction), for: .touchUpInside)
        view.addSubview(customFbLoginButton)
        
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil{
            print(error)
            return
        }
        
        print("Successfully logged in with facebook...")
        showEmailAddress()
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }
    
    fileprivate func showEmailAddress(){
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"id, name, email"]).start { (connection, result, err) in
            if err != nil{
                print("Failed to start graph request ",err)
                return
            }
            
            print(result)
        }
    }
    
    // MARK: - Handle functions
    func handleCustomLoginAction(){
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self)
        { (result, err) in
            if err != nil{
                print("Failed custom fb login ",err)
                return
            }
            
            print(result?.token.tokenString)
            self.showEmailAddress()
        }
    }
    
    
}

