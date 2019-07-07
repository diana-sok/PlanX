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
            signinLabel.text = "Log in!"
            signinButton.setTitle("Log In", for: .normal)
            
        }
        else {
//            signinLabel.text = "Register"
//            signinButton.setTitle("Register", for: .normal)
            self.performSegue(withIdentifier: "goToCreateAccount", sender: self)
            
        }
        
    }
    
    @IBAction func signinButtonTapped(_ sender: UIButton) {
    
        // TODO: do some form of validation on email and password
       
        if let email = emailTextField.text, let pass = passwordTextField.text {
            
            if pass.count < 8 {
                signinLabel.text = "password must be 8 char"
                return
            }
            
            let decimalCharacters = CharacterSet.decimalDigits
            
            let decimalRange = pass.rangeOfCharacter(from: decimalCharacters)
            
            if decimalRange == nil {
                signinLabel.text = "password must have 1 num"
                return
            }
            
            if isSignin {
                Auth.auth().signIn(withEmail: email, password: pass) { [weak self] user, error in
                    guard let strongSelf = self else { return }
                    
                    //check that the user isn't nill
                    if user != nil {
                        //user is found, go to home screen
                        strongSelf.performSegue(withIdentifier: "goToHome", sender: strongSelf)
                        //print(u)
                    }
                    else {
                        //Error: show error message
                        strongSelf.signinLabel.text = "Invalid log in information"
                    }
                }
            }
            else {
                Auth.auth().createUser(withEmail: email, password: pass) { (result, error) in
                    // ...
                    if let error = error {
                        print("Failed to sign user up with error: ", error.localizedDescription)
                        return
                    }
                    guard let uid = result?.user.uid else {return}
                    //let values = ["email": email, "usernmae": username]
                }
                
            }
            
        }
    }
   
    
    
}
