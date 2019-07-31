////
////  ViewClassAssignmentsController.swift
////  PlanX CoursesTab
////
////  Created by admin on 7/11/19.
////  Copyright © 2019 admin. All rights reserved.
////
//
////still needed?
//
//import UIKit
//import FirebaseAuth
//import FirebaseDatabase
//
//var assignments = [String]()
//var myAssignmentIndex = 0;
//
//class ViewClassAssignmentsController: UIViewController, UITableViewDelegate, UITableViewDataSource
//{
//
//    @IBOutlet weak var itemsTableView: UITableView!
//    @IBOutlet weak var titleLabel: UILabel!
//
//    var ref:DatabaseReference?
//
//    //Number if items to display
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return (assignments.count)
//    }
//
//    //What to display
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "assignmentCell")
//        cell.textLabel?.text = assignments[indexPath.row]
//        return(cell)
//    }
//
//    //Deletes list items
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == UITableViewCell.EditingStyle.delete{
//            assignments.remove(at: indexPath.row)
//            itemsTableView.reloadData()
//        }
//    }
//
//    //Refreshes the list
//    override func viewDidAppear(_ animated: Bool) {
//        itemsTableView.reloadData()
//    }
//
//    //Clickable table items
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//        myAssignmentIndex = indexPath.row
//        performSegue(withIdentifier: "assignmentDetailSegue", sender: self)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        // Set Firebase reference
//        let ref = Database.database().reference()
//        let userID = ref.child(Auth.auth().currentUser!.uid) //Get user
//
//        // Get the data from Firebase & listen for new data
//        userID.child("Courses").child(courseList[myCourseIndex]).observeSingleEvent(of: .value) { (snapshot) in
//            for child in snapshot.children {
//                if let childSnapshot = child as? DataSnapshot {
//                    // Turn value into a string
//                    let value = childSnapshot.key as? String
//
//                    // Add courses to list
//                    if let actualValue = value{
//                        assignments.append(actualValue)
//                        self.itemsTableView.reloadData()
//                    }
//                }
//            }
//        }
//
//        //Changes the title
//        titleLabel.text = courseList[myCourseIndex]
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
