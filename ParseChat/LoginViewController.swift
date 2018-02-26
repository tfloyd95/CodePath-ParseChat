//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Tavien on 2/26/18.
//  Copyright © 2018 Warpedflo. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var UsernameField: UITextField!
    
    @IBOutlet weak var PasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OnSignIn(_ sender: Any)
    {
        let username = UsernameField.text ?? ""
        let password = PasswordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
               
            }
        }
    }
    
    
    @IBAction func OnSignUp(_ sender: Any)
    {
        let newUser = PFUser()
        
        // set user properties
        newUser.username = UsernameField.text
        newUser.password = PasswordField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
              
            }
        }
    }

   
}
