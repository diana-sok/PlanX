//
//  ViewAssignmentListViewController.swift
//  PlanX
//
//  Created by admin on 7/26/19.
//  Copyright © 2019 H2OT. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

var assignmentList = [String]()
var myAssignmentIndex = 0;

class ViewAssignmentListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var assignmentsTableView: UITableView!
    @IBOutlet weak var assignmentTypeTitle: UILabel!
    
    var ref:DatabaseReference?
    
    //Number if items to display
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (assignmentList.count)
    }
    
    //What to display
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "assignmentCell2")
        cell.textLabel?.text = assignmentList[indexPath.row]
        return(cell)
    }
    
    //Deletes list items
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            assignmentList.remove(at: indexPath.row)
            assignmentsTableView.reloadData()
        }
    }
    
    //Refreshes the list
    override func viewDidAppear(_ animated: Bool) {
        assignmentsTableView.reloadData()
    }
    
    //Clickable table items
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        myAssignmentIndex = indexPath.row
        performSegue(withIdentifier: "ViewAssignmentSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let courseName = courseList[myCourseIndex]
        let assignmentType = assignmentTypes[myAssignmentTypeIndex]
        var assignmentTypeName = assignmentType
        
        // Clear the string array
        assignmentList = [String]()
        
        // Set Firebase reference
        let ref = Database.database().reference()
        let userID = ref.child(Auth.auth().currentUser!.uid) //Get user
        
        // Get the data from Firebase & listen for new data
        userID.child("Courses").child(courseName).child(assignmentType).observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot {
                    // Turn value into a string
                    let value = childSnapshot.key as? String
                    
                    // Add courses to list
                    if let actualValue = value{
                        if (actualValue != "Percentage")
                        {
                            assignmentList.append(actualValue)
                            self.assignmentsTableView.reloadData()
                        }
                        else if (actualValue == "Percentage")
                        {
                            let perc = childSnapshot.value as? String
                            if let percent = perc{
                                assignmentTypeName = assignmentTypeName + " (" + percent + "%)"
                                //Change the title
                                self.assignmentTypeTitle.text = assignmentTypeName
                            }
                        }
                    }
                }
            }
        }
        
        //Changes the title
        //assignmentTypeTitle.text = assignmentTypeName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
