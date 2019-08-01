//
//  AddAssignmentTypesViewController.swift
//  PlanX
//
//  Created by admin on 7/26/19.
//  Copyright © 2019 H2OT. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AddAssignmentTypesViewController: UIViewController {

    var ref:DatabaseReference?
    
    let courseName = courseList[myCourseIndex]
    
    @IBOutlet weak var courseItem1: UITextField!
    @IBOutlet weak var courseItem1Perc: UITextField!
    
    @IBOutlet weak var courseItem2: UITextField!
    @IBOutlet weak var courseItem2Perc: UITextField!
    
    @IBOutlet weak var courseItem3: UITextField!
    @IBOutlet weak var courseItem3Perc: UITextField!
    
    @IBOutlet weak var courseItem4: UITextField!
    @IBOutlet weak var courseItem4Perc: UITextField!
    
    @IBOutlet weak var courseItem5: UITextField!
    @IBOutlet weak var courseItem5Perc: UITextField!
    
    @IBOutlet weak var noNameError: UILabel!
    @IBOutlet weak var percError1: UILabel!
    @IBOutlet weak var percError2: UILabel!
    @IBOutlet weak var percError3: UILabel!
    @IBOutlet weak var percError4: UILabel!
    @IBOutlet weak var percError5: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        noNameError.text = ""
        percError1.text = ""
        percError2.text = ""
        percError3.text = ""
        percError4.text = ""
        percError5.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func AddAssignTypeButton(_ sender: Any) {
        let ref = Database.database().reference()
        let userID = ref.child(Auth.auth().currentUser!.uid) //Get user
        
        if (courseItem1.text != "" || courseItem2.text != "" || courseItem3.text != "" ||
            courseItem4.text != "" || courseItem5.text != "")
        {
            noNameError.text = ""
            
            percError1.text = ""
            if (courseItem1.text != ""){
                //userID.child("Courses").child(courseName).child(courseItem1.text!).setValue("")
                // Add course specific item percentage if it exists (how much out of 100% for the class)
                if(courseItem1Perc.text != ""){
                    userID.child("Courses").child(courseName).child(courseItem1.text!)
                        .child("Percentage").setValue(courseItem1Perc.text!)
                }
                else{
                    percError1.text = "Please enter a percentage"
                }
            }
            percError2.text = ""
            if (courseItem2.text != ""){
                if(courseItem2Perc.text != ""){
                    userID.child("Courses").child(courseName).child(courseItem2.text!)
                        .child("Percentage").setValue(courseItem2Perc.text!)
                }
                else{
                    percError2.text = "Please enter a percentage"
                }
            }
            percError3.text = ""
            if (courseItem3.text != ""){
                if(courseItem3Perc.text != ""){
                    userID.child("Courses").child(courseName).child(courseItem3.text!)
                        .child("Percentage").setValue(courseItem3Perc.text!)
                }
                else{
                    percError3.text = "Please enter a percentage"
                }
            }
            percError4.text = ""
            if (courseItem4.text != ""){
                if(courseItem4Perc.text != ""){
                    userID.child("Courses").child(courseName).child(courseItem4.text!)
                        .child("Percentage").setValue(courseItem4Perc.text!)
                }
                else{
                    percError4.text = "Please enter a percentage"
                }
            }
            percError5.text = ""
            if (courseItem5.text != ""){
                if(courseItem5Perc.text != ""){
                    userID.child("Courses").child(courseName).child(courseItem5.text!)
                        .child("Percentage").setValue(courseItem5Perc.text!)
                }
                else{
                    percError5.text = "Please enter a percentage"
                }
            }
            if (percError1.text != "Please enter a percentage" &&
                percError2.text != "Please enter a percentage" &&
                percError3.text != "Please enter a percentage" &&
                percError4.text != "Please enter a percentage" &&
                percError5.text != "Please enter a percentage")
            {
                performSegue(withIdentifier: "addCourseTypeSegue", sender: self)
            }
            
        }
        else{
            noNameError.text = "Please input a name"
        }
    }
}
