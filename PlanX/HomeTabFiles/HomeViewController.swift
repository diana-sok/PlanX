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

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CompletionCheckMarkDelegate {
    
    @IBOutlet weak var toDoListTable: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tasksDueToday: UILabel!
    @IBOutlet weak var tasksDueThisWeek: UILabel!
    @IBOutlet weak var tasksDone: UILabel!
    
    // Properties
    var usersName:String = ""
    private var tableList = [String]() //items in table
    private var taskList = [Task]()
    private var completedAssignmentCount = 0
    private var toDoThisWeek = 0
    private var toDoToday = 0

    func didTapCheckbox(status: String) {
        if(status == "complete") {
            print("here is completion")
            completedAssignmentCount += 1
            self.tasksDone.text = "\(completedAssignmentCount)"
            self.tasksDone.reloadInputViews()
        }
        else {
            print("here is incompletion")
            completedAssignmentCount -= 1
            self.tasksDone.text = "\(completedAssignmentCount)"
            self.tasksDone.reloadInputViews()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(tableList.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoListItem", for: indexPath) as! HomeTableViewCell
        cell.toDoListItemLabel.text = taskList[indexPath.row].getName()
        cell.setAssignmentName(name: taskList[indexPath.row].getName())
        cell.setDueDate(date: taskList[indexPath.row].getDueDate())
        cell.setCourseName(course: taskList[indexPath.row].getCourseName())
        cell.setDivisionType(division: taskList[indexPath.row].getDivisionType())
        
        if taskList[indexPath.row].getStatus() == "complete" {
            cell.toDoListCheckButton.setBackgroundImage(UIImage(named: "icons8-checkmark-30"), for: .normal)
        }
        
        cell.selectionDelegate = self
        
        return cell
    }
    
//    func viewLoadSetup() {
//        // Displaying current date on Home View
//        let date = Date()
//        let format = DateFormatter()
//
//        // Current date in short format mm/dd/yyyy
//        format.dateStyle = .short
//        let currentDateShort = format.string(from:date)
//        print(currentDateShort)
//
//        let uid = "\(Auth.auth().currentUser?.uid ?? "someid")"
//        //how to access children of a node example:
//        let coursesRef = Database.database().reference().child(uid).child("Courses")
//        //let coursesRef = Database.database().reference().child("SampleUserID").child("Courses")
//
//        coursesRef.observeSingleEvent(of: .value, with: { snapshot in
//            //children of courses like math or english
//            for child in snapshot.children {
//                if let childSnapshot = child as? DataSnapshot{
//                    print("--course---")
//                    let courseName = childSnapshot.key as String
//                    print(courseName)
//                    print(childSnapshot.key as String)
//                    print("-----------")
//                    //course distributions like tests, homework, project
//                    for grandChild in childSnapshot.children {
//                        if let grandChildSnapshot = grandChild as? DataSnapshot{
//
//                            // Print distribution type: homework/test/project
//                            print("  --distribution")
//                            print("  \(grandChildSnapshot.key as String)")
//                            let divisionType = grandChildSnapshot.key as String
//                            print("  \(divisionType)")
//
//                            // Print distribution's percentage worth of grade
//                            print("  worth: \(grandChildSnapshot.childSnapshot(forPath: "Percentage").value as? Int ?? -1)")
//                            print("  --")
//
//                            // Print assignments in distribution (Homework 1, Homework 2)
//                            for greatGrandChild in grandChildSnapshot.children {
//                                if let greatGrandChildSnapshot = greatGrandChild as? DataSnapshot {
//
//                                    //print data of assignment, recall a child of assignments in Perentage, we already got that info
//                                    if((greatGrandChildSnapshot.key as String) != "Percentage") {
//
//                                        //print name of assignment
//                                        print("    --assignment")
//                                        print("    name of assignment: \(greatGrandChildSnapshot.key as String)")
//
//                                        //populate list to display on Home View
//                                        let assignmentName = greatGrandChildSnapshot.key as String
//
//                                        let status = greatGrandChildSnapshot.childSnapshot(forPath: "status").value as? String ?? "NA  inputted"
//                                        if status == "complete" {
//                                            self.completedAssignmentCount += 1
//                                        }
//
//                                        let score = greatGrandChildSnapshot.childSnapshot(forPath: "status").value as? String ?? "NA  inputted"
//
//                                        var dueDate = greatGrandChildSnapshot.childSnapshot(forPath: "due date").value as? String ?? "NA inputted"
//
//                                        //if date is not in format M/D/YY
//                                        var dateStringArray = [String]()
//
//                                        while dueDate.count != 0 {
//                                            dateStringArray.append(String(dueDate.remove(at: dueDate.startIndex)))
//                                        }
//
//                                        if dateStringArray.count == 8 {
//                                            if dateStringArray[0] == "0" {
//                                                dateStringArray.remove(at: 0)
//                                            } else if dateStringArray[3] == "0" {
//                                                dateStringArray.remove(at: 3)
//                                            }
//                                        }
//
//                                        if dateStringArray.count == 7 {
//                                            if dateStringArray[0] == "0" {
//                                                dateStringArray.remove(at: 0)
//                                            } else if dateStringArray[3] == "0" {
//                                                dateStringArray.remove(at: 3)
//                                            }
//                                        }
//
//                                        dueDate = ""
//                                        for element in dateStringArray {
//                                            dueDate += String(element)
//                                        }
//
//                                        if dueDate == currentDateShort || dueDate == "NA inputted"{
//                                            let task = Task(dueDate: dueDate, name: assignmentName, isComplete: status, courseName: courseName, divisionType: divisionType)
//                                            self.tableList.append(assignmentName)
//                                            self.taskList.append(task)
//                                            self.toDoToday += 1
//
//                                        }
//
//                                        // turn string to date object
//                                        let date = self.stringToDate(dateString: dueDate)
//
//                                        // get start and end of week
//                                        let sunday = self.getSunday(myDate: date)
//                                        let saturday = self.getSaturday(myDate: date)
//
//                                        if (sunday ... saturday).contains(date) {
//                                            self.toDoThisWeek += 1
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//
//                }
//
//            }
//
//            // update table view
//            self.toDoListTable.reloadData()
//
//            self.tasksDueToday.text = "\(self.toDoToday)"
//            self.tasksDone.text = "\(self.completedAssignmentCount)"
//            self.tasksDueThisWeek.text = "\(self.toDoThisWeek)"
//
//        })
//
//    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //viewLoadSetup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Displaying current date on Home View
        let date = Date()
        let format = DateFormatter()
        
        // Current date in short format mm/dd/yyyy
        format.dateStyle = .short
        let currentDateShort = format.string(from:date)
        print(currentDateShort)
        
        format.dateStyle = .full
        let formattedDate = format.string(from: date)
        self.dateLabel.text = formattedDate
        
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
        
//        format.dateStyle = .full
//        let formattedDate = format.string(from: date)
//        self.dateLabel.text = formattedDate
        
        

        /************************
         
         !!!!!!!!! REFERENCE BELOW FOR DATABASE READING!!!!
         
        *******/
        let uid = "\(Auth.auth().currentUser?.uid ?? "someid")"
        //how to access children of a node example:
        let coursesRef = Database.database().reference().child(uid).child("Courses")
        //let coursesRef = Database.database().reference().child("SampleUserID").child("Courses")

        coursesRef.observeSingleEvent(of: .value, with: { snapshot in
            //children of courses like math or english
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot{
                    print("--course---")
                    let courseName = childSnapshot.key as String
                    print(courseName)
                    print(childSnapshot.key as String)
                    print("-----------")
                    //course distributions like tests, homework, project
                    for grandChild in childSnapshot.children {
                        if let grandChildSnapshot = grandChild as? DataSnapshot{

                            // Print distribution type: homework/test/project
                            print("  --distribution")
                            print("  \(grandChildSnapshot.key as String)")
                            let divisionType = grandChildSnapshot.key as String
                            print("  \(divisionType)")

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

                                        let status = greatGrandChildSnapshot.childSnapshot(forPath: "status").value as? String ?? "NA  inputted"
                                        if status == "complete" {
                                            self.completedAssignmentCount += 1
                                        }

                                        let score = greatGrandChildSnapshot.childSnapshot(forPath: "status").value as? String ?? "NA  inputted"

                                        var dueDate = greatGrandChildSnapshot.childSnapshot(forPath: "due date").value as? String ?? "NA inputted"

                                         //if date is not in format M/D/YY
                                        var dateStringArray = [String]()

                                        while dueDate.count != 0 {
                                            dateStringArray.append(String(dueDate.remove(at: dueDate.startIndex)))
                                        }

                                        if dateStringArray.count == 8 {
                                            if dateStringArray[0] == "0" {
                                               dateStringArray.remove(at: 0)
                                            } else if dateStringArray[3] == "0" {
                                                dateStringArray.remove(at: 3)
                                            }
                                        }

                                        if dateStringArray.count == 7 {
                                            if dateStringArray[0] == "0" {
                                                dateStringArray.remove(at: 0)
                                            } else if dateStringArray[3] == "0" {
                                                dateStringArray.remove(at: 3)
                                            }
                                        }

                                        dueDate = ""
                                        for element in dateStringArray {
                                            dueDate += String(element)
                                        }

                                        if dueDate == currentDateShort || dueDate == "NA inputted"{
                                            let task = Task(dueDate: dueDate, name: assignmentName, isComplete: status, courseName: courseName, divisionType: divisionType)
                                            self.tableList.append(assignmentName)
                                            self.taskList.append(task)
                                            self.toDoToday += 1

                                        }

                                        // turn string to date object
                                        let date = self.stringToDate(dateString: dueDate)

                                        // get start and end of week
                                        let sunday = self.getSunday(myDate: date)
                                        let saturday = self.getSaturday(myDate: date)

                                        if (sunday ... saturday).contains(date) {
                                            self.toDoThisWeek += 1
                                        }
                                    }
                                }
                            }
                        }
                    }

                }

            }

            // update table view
            self.toDoListTable.reloadData()

            self.tasksDueToday.text = "\(self.toDoToday)"
            self.tasksDone.text = "\(self.completedAssignmentCount)"
            self.tasksDueThisWeek.text = "\(self.toDoThisWeek)"

        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    func getSunday(myDate: Date) -> Date {
        let cal = Calendar.current
        let comps = cal.dateComponents([.weekOfYear, .yearForWeekOfYear], from: myDate)
        let beginningOfWeek = cal.date(from: comps)!
        return beginningOfWeek
    }
    
    func getSaturday(myDate: Date) -> Date {
        var dateComponent = DateComponents()
        dateComponent.day = 6
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: getSunday(myDate: Date()))
        
        return futureDate!
    }
    
    func stringToDate(dateString: String) -> Date {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MM/dd/yy"
        
        let date = dateFormatterGet.date(from: dateString)
        
        return date!
    }

}

