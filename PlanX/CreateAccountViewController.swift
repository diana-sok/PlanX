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
                    directionsLabel.text = "Bad email format!"
                    return
               }
               
               if password.count < 8 {
                    //directionsLabel.textColor = UIColor.red
                    directionsLabel.text = "Password must contain at least 8 char"
                    return
               }
               
               let decimalCharacters = CharacterSet.decimalDigits
               
               let decimalRange = password.rangeOfCharacter(from: decimalCharacters)
               
               if decimalRange == nil {
                    //directionsLabel.textColor = UIColor.red
                    directionsLabel.text = "Password must contain at least 1 number"
                    return
               }
               
               if let verifyPass = verifyPassTextField.text {
                    if verifyPass != password {
                         //directionsLabel.textColor = UIColor.red
                         directionsLabel.text = "Passwords don't match!"
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
////                    }
//                    if error != nil {
//                         print(error)
//                         return
//                    }
                    self.performSegue(withIdentifier: "createToHome", sender: self)
                    //guard let uid = result?.user.uid else {return}
                    //let values = ["email": email, "usernmae": username]
                    //let ref = Database.database().reference()
                    //ref.child("someid/name").setValue("Mike") //write example
                    //        ref.child("someid/name").observeSingleEvent(of: .value) { (snapshot) in
                    //            let name = snapshot.value as? [String: Any]
                    //            print(name)
                    
//                    if (Auth.auth().currentUser !== nil) {
//                         print("user id: \(Auth.auth().currentUser?.uid)");
//                    }
                    
                    let ref = Database.database().reference()
                    let userReference = ref.child(Auth.auth().currentUser!.uid)
                    let values = ["first name": self.firstNameTextField.text, "last name": self.lastNameTextField.text]
                    userReference.updateChildValues(values)
                    
               }
          }
     }
}
