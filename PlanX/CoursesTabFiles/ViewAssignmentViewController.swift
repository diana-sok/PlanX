//
//  ViewAssignmentViewController.swift
//  PlanX CoursesTab
//
//  Created by admin on 7/14/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewAssignmentViewController: UIViewController {
    
    var ref:DatabaseReference?
    
    var assignName = assignmentList[myAssignmentListIndex]
    let courseName = courseList[myCourseIndex]
    var assignmentTypeName = assignmentTypes[myAssignmentTypeIndex]

    @IBOutlet weak var assignmentName: UILabel!
    @IBOutlet weak var assignmentType: UILabel!
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var details: UILabel!
    
    var dueDatex = ""
    var scorex = ""
    var statusx = ""
    var detailsx = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dueDate.text = ""
        score.text = ""
        status.text = ""
        details.text = ""
        
        // Sets the assignment's name
        assignmentName.text = "   " + assignName
        
        // Sets the assignment's type label
        assignmentType.text = "   " + assignmentTypeName
        
        // Set Firebase reference
        let ref = Database.database().reference()
        let userID = ref.child(Auth.auth().currentUser!.uid) //Get user
        
        // Get the data from Firebase & listen for new data
        userID.child("Courses").child(courseName).child(assignmentTypeName).child(assignName).observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot {
                    // Turn key into a string
                    let key = childSnapshot.key as? String
                    
                    // Turn value into a string
                    let value = childSnapshot.value as? String
                    
                    // Add value to proper location
                    if let actualKey = key{
                        if (actualKey == "due date")
                        {
                            if let actualValue = value{
                                self.dueDate.text = "  (Due) " + actualValue
                                self.dueDatex = actualValue
                            }
                        }
                        else if (self.dueDate.text == ""){
                            self.dueDate.text = "  (Due) N/A" }
                        
                        if (actualKey == "score")
                        {
                            if let actualValue = value{
                                self.score.text = "  (Score) " + actualValue
                                self.scorex = actualValue
                            }
                        }
                        else if(self.score.text == ""){
                            self.score.text = "  (Score) N/A" }
                            
                        if (actualKey == "status")
                        {
                            if let actualValue = value{
                                self.status.text = "  (Status) " + actualValue
                                self.statusx = actualValue
                            }
                        }
                        else if(self.status.text == ""){
                            self.status.text = "  (Status) N/A" }
                            
                        if (actualKey == "details")
                        {
                            if let actualValue = value{
                                self.details.text = "   " + actualValue
                                self.detailsx = actualValue
                            }
                        }
                        else if(self.details.text == ""){
                            self.details.text = "  (Details) N/A" }
                    }
                }
            }
        }
    }
    
    /*
     Index 0 - Course Name
     Index 1 - Assignment Name
     Index 2 - Assignment Type
     Index 3 - Due Date
     Index 4 - Score
     Index 5 - Status (incomplete/complete)
     Index 6 - Details
     */
    func getAssignmentDetails() -> [String]{
        var assignmentDetails = [String]()
        
        assignmentDetails.append(courseName)
        assignmentDetails.append(assignName)
        assignmentDetails.append(assignmentTypeName)
        assignmentDetails.append(dueDatex)
        assignmentDetails.append(scorex)
        assignmentDetails.append(statusx)
        assignmentDetails.append(detailsx)
        
        return assignmentDetails
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! EditAssignmentViewController
        dest.info = getAssignmentDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
}
