//
//  AddCourseViewController.swift
//  PlanX CoursesTab
//
//  Created by admin on 7/10/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AddCourseViewController: UIViewController {
    
    var ref:DatabaseReference?
    
    @IBOutlet weak var courseName: UITextField!

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
    
    
    @IBAction func addCourseButton(_ sender: AnyObject) {
        if (courseName.text != ""){
            let ref = Database.database().reference()
            let userID = ref.child(Auth.auth().currentUser!.uid) //Get user
            
            noNameError.text = ""
            
            // Add a child to the parent:Course with the name of a course
            userID.child("Courses").child(courseName.text!).setValue("")
            
            // Add course specific items if they exist
            percError1.text  = ""
            if(courseItem1.text != ""){
                //userID.child("Courses").child(courseName.text!).child(courseItem1.text!).setValue("")
                // Add course specific item percentage if it exists (how much out of 100% for the class)
                if(courseItem1Perc.text != ""){
                    userID.child("Courses").child(courseName.text!).child(courseItem1.text!)
                        .child("Percentage").setValue(courseItem1Perc.text!)
                }
                else{
                    percError1.text = "Please enter a percentage"
                }
            }
            percError2.text  = ""
            if(courseItem2.text != ""){
                //userID.child("Courses").child(courseName.text!).child(courseItem2.text!)
                //.setValue("")
                if(courseItem2Perc.text != ""){
                    userID.child("Courses").child(courseName.text!).child(courseItem2.text!)
                        .child("Percentage").setValue(courseItem2Perc.text!)
                }
                else{
                    percError2.text = "Please enter a percentage"
                }
            }
            percError3.text  = ""
            if(courseItem3.text != ""){
                //userID.child("Courses").child(courseName.text!).child(courseItem3.text!)
                    //.setValue("")
                if(courseItem3Perc.text != ""){
                    userID.child("Courses").child(courseName.text!).child(courseItem3.text!)
                        .child("Percentage").setValue(courseItem3Perc.text!)
                }
                else{
                    percError3.text = "Please enter a percentage"
                }
            }
            percError4.text  = ""
            if(courseItem4.text != ""){
                //userID.child("Courses").child(courseName.text!).child(courseItem4.text!)
                    //.setValue("")
                if(courseItem4Perc.text != ""){
                    userID.child("Courses").child(courseName.text!).child(courseItem4.text!)
                        .child("Percentage").setValue(courseItem4Perc.text!)
                }else{
                    percError4.text = "Please enter a percentage"
                }
            }
            percError5.text  = ""
            if(courseItem5.text != ""){
                //userID.child("Courses").child(courseName.text!).child(courseItem5.text!)
                    //.setValue("")
                if(courseItem5Perc.text != ""){
                    userID.child("Courses").child(courseName.text!).child(courseItem5.text!)
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
                performSegue(withIdentifier: "courseAdded", sender: self)
            }
        }
        else{
            noNameError.text = "Please enter a course name"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()

        noNameError.text = ""
        percError1.text  = ""
        percError2.text  = ""
        percError3.text  = ""
        percError4.text  = ""
        percError5.text  = ""
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
