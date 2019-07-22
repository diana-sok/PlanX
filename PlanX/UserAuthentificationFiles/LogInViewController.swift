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
import FirebaseDatabase


class LogInViewController: UIViewController {
    
    @IBOutlet weak var signinSelector: UISegmentedControl!
    
    @IBOutlet weak var signinLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signinButton: UIButton!
   
    var isSignin:Bool = true
    //var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        //ref = Database.database().reference()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    @IBAction func signinSelectorChanged(_ sender: UISegmentedControl) {
        
//        //Flip the boolean
//       // isSignin = !isSignin !!!!!
//
//        //check the bool and set the button and labels
//        if isSignin {
//            signinLabel.text = "Log in!"
//            signinButton.setTitle("Log In", for: .normal)
//
//        }
//        else {
//            signinLabel.text = "Register"
//            signinButton.setTitle("Register", for: .normal)
            self.performSegue(withIdentifier: "goToCreateAccount", sender: self)
        
        
            
//        }
        
    }
    
    @IBAction func signinButtonTapped(_ sender: UIButton) {
    
        // TODO: do some form of validation on email and password
       
        if let email = emailTextField.text, let pass = passwordTextField.text {
            
            if !isValidEmail(emailStr: email) {
                signinLabel.text = "Oops. Bad email format!"
                return
            }
//            if pass.count < 8 {
//                signinLabel.text = "Password must contain at least 8 characters"
//                return
//            }
//
//            let decimalCharacters = CharacterSet.decimalDigits
//
//            let decimalRange = pass.rangeOfCharacter(from: decimalCharacters)
//
//            if decimalRange == nil {
//                signinLabel.text = "Password must contain 1 number"
//                return
//            }
            
            //if isSignin {
                Auth.auth().signIn(withEmail: email, password: pass) { [weak self] user, error in
                    guard let strongSelf = self else { return }
                    
                    //check that the user isn't nill
                    if user != nil {
                        //user is found, go to home screen
                        let ref = Database.database().reference()
                        ref.child(Student.sharedInstance.getUID()).observeSingleEvent(of: .value, with: { (snapshot) in
                            let value = snapshot.value as? NSDictionary
                            //Student.sharedInstance.setFirstName(firstName: value?["first name"] as? String ?? "")
                            //Student.sharedInstance.setLastName(lastName: value?["last name"] as? String ?? "")
                            Student.sharedInstance.firstName = (value?["first name"] as? String ?? "")
                            Student.sharedInstance.lastName = (value?["last name"] as? String ?? "")
                        }) { (error) in
                            print(error.localizedDescription)
                        }
                        
                        // Go to the home screen
                        strongSelf.performSegue(withIdentifier: "goToHome", sender: strongSelf)
                        
                    }
                    else {
                        //Error: show error message
                        strongSelf.signinLabel.text = "Invalid login information"
                    }
                }
            //}
//            else {
//                Auth.auth().createUser(withEmail: email, password: pass) { (result, error) in
//                    // ...
//                    if let error = error {
//                        print("Failed to sign user up with error: ", error.localizedDescription)
//                        return
//                    }
//                    guard let uid = result?.user.uid else {return}
//                    //let values = ["email": email, "usernmae": username]
//                }
//
//            }
            
        }
    }
   
    
    
}
