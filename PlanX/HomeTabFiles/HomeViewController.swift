//
//  HomeViewController.swift
//  PlanX
//
//  Created by Diana Sok on 7/9/19.
//  Copyright © 2019 H2OT. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tasksDueToday: UILabel!
    @IBOutlet weak var tasksDueThisWeek: UILabel!
    @IBOutlet weak var tasksDone: UILabel!
    
    // Properties
    var usersName:String = ""
    private var tableList = [String]() //items in table
    private var completedAssignmentCount = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(tableList.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoListItem", for: indexPath) as! HomeTableViewCell
        cell.toDoListItemLabel.text = tableList[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.usersName = Student.sharedInstance.getName()
//        print(Student.sharedInstance.getName())
//        self.nameLabel.text = self.usersName
        
        //sep
//        print(Student.sharedInstance.getFirstName())
//        print(Student.sharedInstance.getLastName())
        
       // self.usersName = Student.sharedInstance.firstName + Student.sharedInstance.lastName
       // self.nameLabel.text = self.usersName
        
        
        // Displaying users name by reading from database
//        let userID = Auth.auth().currentUser?.uid
//        let ref = Database.database().reference()
//
//        ref.child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
//            let value = snapshot.value as? NSDictionary
//            self.usersName = value?["first name"] as? String ?? ""
//            self.usersName += " "
//            self.usersName += value?["last name"] as? String ?? ""
//            self.nameLabel.text = self.usersName
//
//        }) { (error) in
//            print(error.localizedDescription)
//        }
        
        // Displaying current date on Home View
        let date = Date()
        let format = DateFormatter()
//        format.dateStyle = .full
//        let formattedDate = format.string(from: date)
//        self.dateLabel.text = formattedDate
        
        // Current date in short format mm/dd/yyyy
        format.dateStyle = .short
        let currentDateShort = format.string(from:date)
        print(currentDateShort)

        /************************
         
         !!!!!!!!! REFERENCE BELOW FOR DATABASE READING!!!!
         
        *******/
        
        //how to access children of a node example:
        let coursesRef = Database.database().reference().child("SampleUserID").child("Courses")
        coursesRef.observeSingleEvent(of: .value, with: { snapshot in
            //children of courses like math or english
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot{
                    print("--course---")
                    print(childSnapshot.key as String)
                    print("-----------")
                    //course distributions like tests, homework, project
                    for grandChild in childSnapshot.children {
                        if let grandChildSnapshot = grandChild as? DataSnapshot{
                            
                            // Print distribution type: homework/test/project
                            print("  --distribution")
                            print("  \(grandChildSnapshot.key as String)")
                            
                            // Print distribution's percentage worth of grade
                            print("  worth: \(grandChildSnapshot.childSnapshot(forPath: "Percentage").value as? Int ?? -1)")
                            print("  --")
                            
                            // Print assignments in distribution (Homework 1, Homework 2)
                            for greatGrandChild in grandChildSnapshot.children {
                                if let greatGrandChildSnapshot = greatGrandChild as? DataSnapshot {
                                    
                                    //print data of assignment, recall a child of assignments in Perentage, we already got that info
                                    if((greatGrandChildSnapshot.key as String) != "Percentage") {
                                        
                                        //print name of assignment
                                        print("    --assignment")
                                        print("    name of assignment: \(greatGrandChildSnapshot.key as String)")
                                        
                                        //populate list to display on Home View
                                        let assignmentName = greatGrandChildSnapshot.key as String
                                        let dueDate = greatGrandChildSnapshot.childSnapshot(forPath: "due date").value as? String ?? "NA inputted"
                                        if dueDate == currentDateShort {
                                            print("!!!!!!!!!!!appending \(assignmentName)!!!!!!!!")
                                            self.tableList.append(assignmentName)
                                        }
                                        
                                        let status = greatGrandChildSnapshot.childSnapshot(forPath: "status").value as? String ?? "NA  inputted"
                                        if status == "complete" {
                                            self.completedAssignmentCount += 1
                                        }

                                        print("       \(greatGrandChildSnapshot.childSnapshot(forPath: "due date").value as? String ?? "NA inputted")")
                                        print("       today's date: \(currentDateShort)")
                                        print("       \(greatGrandChildSnapshot.childSnapshot(forPath: "score").value as? Int ?? -1)")
                                        print("       \(greatGrandChildSnapshot.childSnapshot(forPath: "status").value as? String ?? "NA  inputted")")
                                    }
                                   
                                    //print("    \(greatGrandChildSnapshot.key as String)")
//                                    let k = greatGrandChildSnapshot.key as String
//                                    if(k == "Percentage") {
//                                        print("    found the percentage")
//                                        //let v = greatGrandChildSnapshot.value as? NSDictionary
//                                        //v.value?["due date"] as? String ?? ""
//                                    }
//                                    else {
////                                        let due = greatGrandChildSnapshot.childSnapshot(forPath: "due date").value as? NSDictionary
////                                        let score = greatGrandChildSnapshot.childSnapshot(forPath: "score").value as? NSDictionary
////                                        let status = greatGrandChildSnapshot.childSnapshot(forPath: "status").value as? NSDictionary
////
////                                        print("    \(due as? String)")
////                                       print("    \(greatGrandChildSnapshot.childSnapshot(forPath: "score").value as? NSDictionary)")
////                                        print("    \(greatGrandChildSnapshot.childSnapshot(forPath: "status").value as? NSDictionary)")
//                                        print("    \(greatGrandChildSnapshot.childSnapshot(forPath: "due date").value as? String ?? "none")")
//                                        print("    \(greatGrandChildSnapshot.childSnapshot(forPath: "score").value as? Int ?? 0)")
//                                        print("    \(greatGrandChildSnapshot.childSnapshot(forPath: "status").value as? String ?? "none")")
//                                    }
                                    //print()
                                }
                            }
                        }
                    }

                }
            
//                if let childSnapshot = child as? DataSnapshot,
//                    let dict = childSnapshot as? [String:Any]{
//                    let enumerator = snapshot.children
//                    print("doo")
//                    while let rest = enumerator.nextObject() as? DataSnapshot {
//                        print(rest.value as? [String: Any])
//                    }
//                }
                
            }
            
            self.loadView()
            
            // Displauy items due tpday
            print("hello here!!")
            for element in self.tableList {
                print(element, terminator: " ")
            }
            
            self.tasksDueToday.text = "\(self.tableList.count)"
            self.tasksDone.text = "\(self.completedAssignmentCount)"
            
            let userID = Auth.auth().currentUser?.uid
            let ref = Database.database().reference()
            
            ref.child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                self.usersName = value?["first name"] as? String ?? ""
                self.usersName += " "
                self.usersName += value?["last name"] as? String ?? ""
                self.nameLabel.text = self.usersName
                
            }) { (error) in
                print(error.localizedDescription)
            }
            
            format.dateStyle = .full
            let formattedDate = format.string(from: date)
            self.dateLabel.text = formattedDate
            // Update Home View to display today's due assignments
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
}

