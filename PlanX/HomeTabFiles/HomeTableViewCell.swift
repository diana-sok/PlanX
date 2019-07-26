//
//  HomeTableViewCell.swift
//  PlanX
//
//  Created by Diana Sok on 7/9/19.
//  Copyright © 2019 H2OT. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

//delegation pattern
protocol CompletionCheckMarkDelegate {
    //boss's command --> what it can tell intern to do
    func didTapCheckbox(status:String)
}
class HomeTableViewCell: UITableViewCell {
    
    var selectionDelegate: CompletionCheckMarkDelegate?
    
    
    @IBOutlet weak var toDoListCheckButton: UIButton!
    @IBOutlet weak var toDoListItemLabel: UILabel!
    
    private var assignmentName = ""
    private var dueDate = ""
    private var divisionType = ""
    private var courseName = ""
    
    func setAssignmentName(name:String) {
        assignmentName = name
    }
    func setDueDate(date:String) {
        dueDate = date
    }
    func setDivisionType(division:String) {
        divisionType = division
    }
    func setCourseName(course:String) {
        courseName = course
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func toDoListCheckButtonTapped(_ sender: UIButton) {
        
        let ref = Database.database().reference()

        if toDoListCheckButton.currentBackgroundImage != UIImage(named: "icons8-checkmark-30") {
            toDoListCheckButton.setBackgroundImage(UIImage(named: "icons8-checkmark-30"), for: .normal)
            selectionDelegate?.didTapCheckbox(status: "complete")
            
            let uid = "\(Auth.auth().currentUser?.uid ?? "someid")"
            //let uid = "SampleUserID"
            //ref.child(uid).child("Courses").child("\(courseName)").child("\(divisionType)").child("\(assignmentName)").setValue(["status": "complete"])
            ref.child("\(uid)/Courses/\(courseName)/\(divisionType)/\(assignmentName)/status").setValue("complete")
            
        }
        else {
            toDoListCheckButton.setBackgroundImage(nil, for: .normal)
            let uid = "\(Auth.auth().currentUser?.uid ?? "someid")"
            selectionDelegate?.didTapCheckbox(status: "incomplete")
            //let uid = "SampleUserID"
            //ref.child(uid).child("Courses").child("\(courseName)").child("\(divisionType)").child("\(assignmentName)").setValue(["status": "incomplete"])
            ref.child("\(uid)/Courses/\(courseName)/\(divisionType)/\(assignmentName)/status").setValue("incomplete")
            
            
        }
    }
}
