//
//  CreateAccountViewController.swift
//  PlanX
//
//  Created by Diana Sok on 7/5/19.
//  Copyright © 2019 H2OT. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateAccountViewController: UIViewController {
     
     @IBOutlet weak var signInSelector: UISegmentedControl!
     
     @IBOutlet weak var directionsLabel: UILabel!
     
     @IBOutlet weak var firstNameTextField: UITextField!
     
     @IBOutlet weak var lastNameTextField: UITextField!
     
     @IBOutlet weak var emailTextField: UITextField!
     
     @IBOutlet weak var passWordTextField: UITextField!
     
     @IBOutlet weak var verifyPassTextField: UITextField!
     
     @IBOutlet weak var createAccountButton: UIButton!
     
     override func viewDidLoad() {
          super.viewDidLoad()
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
     @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
          self.performSegue(withIdentifier: "goToSignIn", sender: self)
     }
     
     @IBAction func createAccountButtonTapped(_ sender: UIButton) {
          if let firstName = firstNameTextField.text {
               if firstName == "" {
                    directionsLabel.text = "invalid first"
                    return
               }
          }
          
          if let lastName = lastNameTextField.text {
               if lastName == "" {
                    directionsLabel.text = "invalid last"
                    return
               }

          }
          
//          if let email = emailTextField.text {
//               testsPassedCount += 1
//               print(email)
//          }
          
//          if let password = passWordTextField.text {
//               testsPassedCount += 1
//               if password.count < 8 {
//                    directionsLabel.text = "password must be 8 char"
//                    return
//               }
//
//               let decimalCharacters = CharacterSet.decimalDigits
//
//               let decimalRange = password.rangeOfCharacter(from: decimalCharacters)
//
//               if decimalRange == nil {
//                    directionsLabel.text = "password must have 1 num"
//                    return
//               }
//          }
          
          if let email = emailTextField.text, let password = passWordTextField.text {
               if !isValidEmail(emailStr: email) {
                    directionsLabel.text = "bad email"
                    return
               }
               
               if password.count < 8 {
                    //directionsLabel.textColor = UIColor.red
                    directionsLabel.text = "password must be 8 char"
                    return
               }
               
               let decimalCharacters = CharacterSet.decimalDigits
               
               let decimalRange = password.rangeOfCharacter(from: decimalCharacters)
               
               if decimalRange == nil {
                    //directionsLabel.textColor = UIColor.red
                    directionsLabel.text = "password must have 1 num"
                    return
               }
               
               if let verifyPass = verifyPassTextField.text {
                    if verifyPass != password {
                         //directionsLabel.textColor = UIColor.red
                         directionsLabel.text = "passwords don't match"
                         return
                    }
               }
               
               Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    // ...
//                    if let error = error {
//                         print("Failed to sign user up with error: ", error.localizedDescription)
//                         self.directionsLabel.text = "oh no! create account failed"
//                         return
//                    }
//                    catch error {
//                         print()
//                    }
                    
                    self.performSegue(withIdentifier: "createToHome", sender: self)
                    //guard let uid = result?.user.uid else {return}
                    //let values = ["email": email, "usernmae": username]
                    let ref = Database.database().reference()
                    ref.child("someid/name").setValue("Mike") //write example
                    //        ref.child("someid/name").observeSingleEvent(of: .value) { (snapshot) in
                    //            let name = snapshot.value as? [String: Any]
                    //            print(name)
                    
               }
          }
     }
}
