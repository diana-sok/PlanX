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

class HomeTableViewCell: UITableViewCell {

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
 //   private var task:Task
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        task
//    }
//    init(aTask:Task) {
//        super.init
//        task = aTask
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    
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
            
            print("course name \(courseName)")
            print("division type \(divisionType)")
            print("assignment name \(assignmentName)")
            
            //print()
            let uid = "\(Auth.auth().currentUser?.uid ?? "someid")"
            //let uid = "SampleUserID"
            ref.child(uid).child("Courses").child("\(courseName)").child("\(divisionType)").child("\(assignmentName)").setValue(["status": "complete"])
        }
        else {
            toDoListCheckButton.setBackgroundImage(nil, for: .normal)
            let uid = "\(Auth.auth().currentUser?.uid ?? "someid")"
            //let uid = "SampleUserID"
            ref.child(uid).child("Courses").child("\(courseName)").child("\(divisionType)").child("\(assignmentName)").setValue(["status": "incomplete"])
        }
    }
}
