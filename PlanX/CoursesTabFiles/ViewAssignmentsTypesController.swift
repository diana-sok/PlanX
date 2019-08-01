//
//  ViewAssignmentsTypesController.swift
//  PlanX CoursesTab
//
//  Created by admin on 7/11/19.
//  Copyright © 2019 H2OT admin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

var assignmentTypes = [String]()
var myAssignmentTypeIndex = 0;

class ViewAssignmentsTypesController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //var ref:DatabaseReference?
    let ref = Database.database().reference()
    
    //Number if items to display
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (assignmentTypes.count)
    }

    //What to display
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "assignmentCell")
        cell.textLabel?.text = assignmentTypes[indexPath.row]
        return(cell)
    }
    
    //Deletes list items
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            // Remove from database
            let userID = ref.child(Auth.auth().currentUser!.uid) //Get user
            userID.child("Courses").child(courseList[myCourseIndex])
                .child(assignmentTypes[indexPath.row]).removeValue()
            
            // Remove from string array
            assignmentTypes.remove(at: indexPath.row)
            
            // If there are no more assignment types, recreate the course bc it's removed as well
            if (assignmentTypes.count == 0){
                userID.child("Courses").child(courseList[myCourseIndex]).setValue("")
            }
            
            itemsTableView.reloadData()
        }
    }
    
    //Refreshes the list
    override func viewDidAppear(_ animated: Bool) {
        itemsTableView.reloadData()
    }
    
    //Clickable table items
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        myAssignmentTypeIndex = indexPath.row
        performSegue(withIdentifier: "ViewAssignmentsSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Clear the string array
        assignmentTypes = [String]()
        
        // Set Firebase reference
        //let ref = Database.database().reference()
        let userID = ref.child(Auth.auth().currentUser!.uid) //Get user
        
        // Get the data from Firebase & listen for new data
        userID.child("Courses").child(courseList[myCourseIndex]).observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot {
                    // Turn value into a string
                    let value = childSnapshot.key as? String
                    
                    // Add courses to list
                    if let actualValue = value{
                        assignmentTypes.append(actualValue)
                        self.itemsTableView.reloadData()
                    }
                }
            }
        }

        //Changes the title
        titleLabel.text = courseList[myCourseIndex]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
