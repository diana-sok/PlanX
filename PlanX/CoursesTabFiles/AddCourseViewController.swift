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
    
    
    @IBAction func addCourseButton(_ sender: AnyObject) {
        if (courseName.text != ""){
            let ref = Database.database().reference()
            let userID = ref.child(Auth.auth().currentUser!.uid) //Get user
            
            // Add a child to the parent:Course with the name of a course
            userID.child("Courses").child(courseName.text!).setValue("")
            
            // Add course specific items if they exist
            if(courseItem1.text != ""){
                userID.child("Courses").child(courseName.text!).child(courseItem1.text!)
                // Add course specific item percentage if it exists (how much out of 100% for the class)
                if(courseItem1Perc.text != ""){
                    userID.child("Courses").child(courseName.text!).child(courseItem1.text!)
                        .child("Percentage").setValue(courseItem1Perc.text!)
                }
            }
            if(courseItem2.text != ""){
                userID.child("Courses").child(courseName.text!).child(courseItem2.text!)
                if(courseItem2Perc.text != ""){
                    userID.child("Courses").child(courseName.text!).child(courseItem2.text!)
                        .child("Percentage").setValue(courseItem2Perc.text!)
                }
            }
            if(courseItem3.text != ""){
                userID.child("Courses").child(courseName.text!).child(courseItem3.text!)
                if(courseItem3Perc.text != ""){
                    userID.child("Courses").child(courseName.text!).child(courseItem3.text!)
                        .child("Percentage").setValue(courseItem3Perc.text!)
                }
            }
            if(courseItem4.text != ""){
                userID.child("Courses").child(courseName.text!).child(courseItem4.text!)
                if(courseItem4Perc.text != ""){
                    userID.child("Courses").child(courseName.text!).child(courseItem4.text!)
                        .child("Percentage").setValue(courseItem4Perc.text!)
                }
            }
            if(courseItem5.text != ""){
                userID.child("Courses").child(courseName.text!).child(courseItem5.text!)
                if(courseItem5Perc.text != ""){
                    userID.child("Courses").child(courseName.text!).child(courseItem5.text!)
                        .child("Percentage").setValue(courseItem5Perc.text!)
                }
            }
            
            
            //Add to list
            //courseList.append(courseName.text!)
            courseName.text = "";
            
            performSegue(withIdentifier: "courseAdded", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
