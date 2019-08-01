//
//  EditAssignmentViewController.swift
//  PlanX CoursesTab
//
//  Created by admin on 7/14/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class EditAssignmentViewController: UIViewController {
    
    @IBOutlet weak var newAssignmentName: UITextField!
    @IBOutlet weak var newAssignmentType: UITextField!
    @IBOutlet weak var newDueDate: UITextField!
    @IBOutlet weak var newScore: UITextField!
    @IBOutlet weak var newStatus: UITextField!
    @IBOutlet weak var newDetails: UITextView!
    
    @IBOutlet weak var noNameError: UILabel!
    @IBOutlet weak var noTypeError: UILabel!
    @IBOutlet weak var badDateError: UILabel!
    @IBOutlet weak var badStatusError: UILabel!
    
    
    var info = [String]()
    var courseName = ""
    
    // Variables to hold values
    var aName = ""
    var type = ""
    var dueDate = ""
    var score = ""
    var status = ""
    var details = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Get old info to display
        courseName = info[0]
        newAssignmentName.text = info[1]
        newAssignmentType.text = info[2]
        newDueDate.text = info[3]
        newScore.text = info[4]
        newStatus.text = info[5]
        newDetails.text = info[6]
        
        // Save old info
        aName = info[1]
        type = info[2]
        
        // Clear initial labels
        noNameError.text = ""
        noTypeError.text = ""
        badDateError.text = ""
        badStatusError.text = ""
    }

    @IBAction func saveAssignmentButton(_ sender: Any) {
        
        // Set Firebase reference
        let ref = Database.database().reference()
        let userID = ref.child(Auth.auth().currentUser!.uid) //Get user
        
        if (newAssignmentType.text != "")
        {
            noTypeError.text = ""
            
            if (newAssignmentName.text != "")
            {
                noNameError.text = ""
                
                if (newDueDate.text != ""){
                    if (isValidDate(dateStr: newDueDate.text!))
                    {
                        badDateError.text = ""
                        
                        if (newStatus.text != ""){
                            let stat = newStatus.text!.lowercased()
                            if (isValidStatus(statusStr: stat))
                            {
                                // Remove old data
                                userID.child("Courses").child(courseName).child(type).child(aName).removeValue()
                                
                                // Set new data
                                
                                // Add the due date
                                userID.child("Courses").child(courseName).child(newAssignmentType.text!)
                                    .child(newAssignmentName.text!).child("due date").setValue(newDueDate.text!)
                                
                                // Add the status
                                userID.child("Courses").child(courseName).child(newAssignmentType.text!)
                                    .child(newAssignmentName.text!).child("status").setValue(stat)
                                badStatusError.text = ""
                                
                                if (newScore.text != "")
                                {
                                    userID.child("Courses").child(courseName).child(newAssignmentType.text!)
                                        .child(newAssignmentName.text!).child("score").setValue(newScore.text!)
                                }
                                if (newDetails.text != ""){
                                    userID.child("Courses").child(courseName).child(newAssignmentType.text!)
                                        .child(newAssignmentName.text!).child("details").setValue(newDetails.text!)
                                }
                                
                                performSegue(withIdentifier: "assignmentSaved", sender: self)
                            }
                            else{ badStatusError.text = "Please enter incomplete or complete" }
                        }
                        else{ badStatusError.text = "Please enter a status" }
                    }
                    else{ badDateError.text = "Please enter correct date format" }
                }
                else{ badDateError.text = "Please enter a due date" }
            }
            else{ noNameError.text = "Please enter assignment name" }
        }
        else{ noTypeError.text = "Please enter assignment type" }
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
    
    func isValidStatus(statusStr:String) -> Bool{
        if (statusStr == "incomplete" || statusStr == "complete")
        {
            return true
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! ViewAssignmentViewController
        dest.assignName = newAssignmentName.text!
        dest.assignmentTypeName = newAssignmentType.text!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
