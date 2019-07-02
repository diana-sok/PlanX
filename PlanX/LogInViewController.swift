//
//  LogInViewController.swift
//  PlanX
//
//  Created by Diana Sok on 7/2/19.
//  Copyright © 2019 H2OT. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth


class LogInViewController: UIViewController {
    
    @IBOutlet weak var signinSelector: UISegmentedControl!
    
    @IBOutlet weak var signinLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signinButton: UIButton!
   
    var isSignin:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    @IBAction func signinSelectorChanged(_ sender: UISegmentedControl) {
        
        //Flip the boolean
        isSignin = !isSignin
        
        //check the bool and set the button and labels
        if isSignin {
            signinLabel.text = "Sign In"
            signinButton.setTitle("Sign In", for: .normal)
        }
        else {
            signinLabel.text = "Register"
            signinButton.setTitle("Register", for: .normal)
            
        }
        
    }
    
    @IBAction func signinButtonTapped(_ sender: UIButton) {
    
        // TODO: do some form validation on email and password
       
        if let email = emailTextField.text, let pass = passwordTextField.text {
            
            if isSignin {
                Auth.auth().signIn(withEmail: email, password: pass) { [weak self] user, error in
                    guard let strongSelf = self else { return }
                    // ...
                }
            }
            else {
                Auth.auth().createUser(withEmail: email, password: pass) { authResult, error in
                    // ...
                }            }
            
        }

    
    
    }
    
}
