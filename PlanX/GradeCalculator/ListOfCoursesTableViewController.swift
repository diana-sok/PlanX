//
//  ListOfCoursesTableViewController.swift
//  PlanX
//
//  Created by Roshini  Malempati  on 7/31/19.
//  Copyright © 2019 H2OT. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

// global variables
var listOfCourses = [String]()
var courseIndex = 0

class ListOfCoursesTableViewController: UITableViewController {
    
    // table view variable
    @IBOutlet var CourseTableView: UITableView!
    
    // refer to database
    var reference:DatabaseReference?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Set Firebase reference
        let ref = Database.database().reference()
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
                        self.CourseTableView.reloadData()
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return(courseList.count)
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "CourseCell")
        cell.textLabel?.text = courseList[indexPath.row]
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            courseList.remove(at: indexPath.row)
            //  In the future put stuff to delete from database
            CourseTableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        CourseTableView.reloadData()
    }
    
    //Clickable table items
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        myCourseIndex = indexPath.row
        performSegue(withIdentifier: "ViewAssignments", sender: self)
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
