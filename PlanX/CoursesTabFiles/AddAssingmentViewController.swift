//
//  AddAssingmentViewController.swift
//  PlanX CoursesTab
//
//  Created by admin on 7/14/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AddAssingmentViewController: UIViewController {

    @IBOutlet weak var assignmentName: UITextField!
    @IBOutlet weak var dueDate: UITextField!
    @IBOutlet weak var percentage: UITextField!
    @IBOutlet weak var status: UITextField!
    @IBOutlet weak var details: UITextView!
    
    @IBOutlet weak var noNameError: UILabel!
    @IBOutlet weak var dateError: UILabel!
    @IBOutlet weak var statusError: UILabel!
    
    
    @IBAction func addAssignmentButton(_ sender: AnyObject) {
        if (assignmentName.text != ""){
            
            let ref = Database.database().reference()
            let userID = ref.child(Auth.auth().currentUser!.uid) //Get user
            
            // Name of the course (Math, Science, etc)
            let courseName = courseList[myCourseIndex]
            // Name of assignment type (Homework, Projet, etc)
            let assignmentType = assignmentTypes[myAssignmentTypeIndex]
            
            // Add a child to the GrandpParent:Course, Parent:CourseName, with the name of the assignment
            userID.child("Courses").child(courseName).child(assignmentType).child(assignmentName.text!).setValue("")
            noNameError.text = ""
            
            // Add course specific items if they exist
            if(dueDate.text != ""){
                if (isValidDate(dateStr: dueDate.text!))
                {
                    userID.child("Courses").child(courseName).child(assignmentType).child(assignmentName.text!).child("due date").setValue(dueDate.text!)
                    dateError.text = ""
                    
                    if(status.text != "")
                    {
                        let stat = status.text!.lowercased()
                        if (isValidStaus(statusStr: stat))
                        {
                            userID.child("Courses").child(courseName).child(assignmentType).child(assignmentName.text!).child("status").setValue(stat)
                            statusError.text = ""
                            
                            if(percentage.text != ""){
                                userID.child("Courses").child(courseName).child(assignmentType).child(assignmentName.text!).child("score").setValue(percentage.text!)
                            }
                            if(details.text != ""){
                                userID.child("Courses").child(courseName).child(assignmentType).child(assignmentName.text!).child("details").setValue(details.text!)
                            }
                            
                            performSegue(withIdentifier: "assignmentAdded", sender: self)
                        }
                        else{ statusError.text = "Please input incomplete or complete "}
                    }
                    else{ statusError.text = "Please input a status" }
                }
                else{ dateError.text = "Please input correct format" }
            }
            else{ dateError.text = "Please input a date" }
        }
        else{ noNameError.text = "Please input a name" }
        
        
        //Diana
        let date = dueDate.text ?? "NA Inputted"
        let taskName = assignmentName.text!  // replace for name of assignment
        let courseName = courseList[myCourseIndex] //replace for course this assignment belongs to ie. Math
        let divisionType = "to be inputted"//assignmentType.text ?? "NA Inputted" // replace for Homework ,Test, Project
        let isComplete = "incomplete"
        
        //let date = "07/29/19"
        //let taskName = "this is the assignment ok"
        //let courseName = "Math"
        //let divisionType = "Homework"
        //let isComplete = "incomplete"
        
        let task = Task(dueDate: date, name: taskName, isComplete: isComplete, courseName: courseName, divisionType: divisionType)
        
        print("---")
        print(task.getName())
        print(taskName)
        
        print("---")
        let name = Notification.Name(rawValue: taskAddedNotificationKey)
        NotificationCenter.default.post(name: name, object: nil, userInfo: ["task" : task])
        
        //diana end
    }
    
    func isValidDate(dateStr:String) -> Bool{
        if (dateStr.contains("/")){
            let dateArray = dateStr.components(separatedBy: "/")
            
            if (dateArray.count == 3){
                let first:Int? = Int(dateArray[0])
                if let first = first{
                    if (first >= 1 && first <= 12){
                        let second:Int? = Int(dateArray[1])
                        if let second = second{
                            if (second >= 1 && second <= 31){
                                if (dateArray[2].count == 2){
                                    let third:Int? = Int(dateArray[2])
                                    if third != nil{
                                        return true
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return false
    }
    
    func isValidStaus(statusStr:String) -> Bool{
        if (statusStr == "incomplete" || statusStr == "complete")
        {
            return true
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set error message as empty string at first
        noNameError.text = ""
        dateError.text = ""
        statusError.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be rec reated.
    }
}
