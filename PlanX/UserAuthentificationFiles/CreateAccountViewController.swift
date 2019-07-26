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
     //testing
     override func viewDidLoad() {
          super.viewDidLoad()
          
          NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
          NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
          
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
                    shake(view: directionsLabel)
                    shake(view: firstNameTextField)
                    directionsLabel.text = "Invalid First Name!"
                    return
               }
          }
          
          if let lastName = lastNameTextField.text {
               if lastName == "" {
                    shake(view: directionsLabel)
                    shake(view: lastNameTextField)
                    directionsLabel.text = "Invalid Last Name"
                    return
               }

          }
          
          if let email = emailTextField.text, let password = passWordTextField.text {
               if !isValidEmail(emailStr: email) {
                    shake(view: directionsLabel)
                    shake(view: emailTextField)
                    directionsLabel.text = "Bad email format!"
                    return
               }
               
               if password.count < 8 {
                    //directionsLabel.textColor = UIColor.red
                    shake(view: directionsLabel)
                    shake(view: passWordTextField)
                    directionsLabel.text = "Password must contain at least 8 char"
                    return
               }
               
               let decimalCharacters = CharacterSet.decimalDigits
               
               let decimalRange = password.rangeOfCharacter(from: decimalCharacters)
               
               if decimalRange == nil {
                    //directionsLabel.textColor = UIColor.red
                    shake(view: directionsLabel)
                    shake(view: passWordTextField)
                    directionsLabel.text = "Password must contain at least 1 number"
                    return
               }
               
               if let verifyPass = verifyPassTextField.text {
                    if verifyPass != password {
                         shake(view: directionsLabel)
                         shake(view: passWordTextField)
                         shake(view: verifyPassTextField)
                         directionsLabel.text = "Passwords don't match!"
                         return
                    }
               }
               
               Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    
                    let firstName = self.firstNameTextField.text
                    let lastName = self.lastNameTextField.text
                    
                    // Update database with name
                    let ref = Database.database().reference()
                    let userReference = ref.child(Auth.auth().currentUser!.uid)
                    let values = ["first name": firstName, "last name": lastName]
                     userReference.updateChildValues(values as [AnyHashable : Any])
                    
                    // Update Singleton
                    Student.sharedInstance.setFirstName(firstName: firstName ?? "noam")
                    Student.sharedInstance.setLastName(lastName: lastName ?? "chomsky")
                    //Student.sharedInstance.firstName = firstName ?? "noam"
                    //Student.sharedInstance.lastName = lastName ?? "chomsky"
                    
                    self.performSegue(withIdentifier: "createToHome", sender: self)
                    
               }
          }
     }
     
     // shakes any view
     func shake(view: UIView, for duration: TimeInterval = 0.5, withTranslation translation: CGFloat = 10) {
          let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
               view.transform = CGAffineTransform(translationX: translation, y: 0)
          }
          
          propertyAnimator.addAnimations({
               view.transform = CGAffineTransform(translationX: 0, y: 0)
          }, delayFactor: 0.2)
          
          propertyAnimator.startAnimation()
     }
}
