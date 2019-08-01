//
//  MainCoursesViewController.swift
//  PlanX CoursesTab
//
//  Created by admin on 7/9/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

var courseList = [String]()
var myCourseIndex = 0;

class MainCoursesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var coursesTableView: UITableView!
    
    //var ref:DatabaseReference?
    let ref = Database.database().reference()

    //Number of cells to display
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(courseList.count)
        //return(list.count)
    }

    //Displays each element
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        //cell.textLabel?.text = list[indexPath.row]
        cell.textLabel?.text = courseList[indexPath.row]
        return(cell)
    }

    //Deletes list items
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            // Remove from database
            let userID = ref.child(Auth.auth().currentUser!.uid) //Get user
            userID.child("Courses").child(courseList[indexPath.row]).removeValue()
            
            // Remove from string array
            courseList.remove(at: indexPath.row)
            
            // If there are no more courses, recreate "Course" bc it's removed as well
            if (courseList.count == 0){
                userID.child("Courses").setValue("")
            }
            
            coursesTableView.reloadData()
        }
    }

    //Refreshes the list
    override func viewDidAppear(_ animated: Bool) {
        coursesTableView.reloadData()
    }
    
    //Clickable table items
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        myCourseIndex = indexPath.row
        performSegue(withIdentifier: "itemViewSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseList = [String]()
        
        // Set Firebase reference
        //let ref = Database.database().reference()
        let userID = ref.child(Auth.auth().currentUser!.uid) //Get user
        
        // Get the data from Firebase & listen for new data
        userID.child("Courses").observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot {
                    // Turn value into a string
                    let value = childSnapshot.key as? String
                    
                    // Add courses to list
                    if let actualValue = value{
                        courseList.append(actualValue)
                        self.coursesTableView.reloadData()
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

