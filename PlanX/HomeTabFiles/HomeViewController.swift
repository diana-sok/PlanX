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

let taskAddedNotificationKey = "co.planx.taskAdded"
let taskEditedNotificationKey = "co.planx.taskEdited"
let taskDeletedNotificationKey = "co.planx.taskDeleted"

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CompletionCheckMarkDelegate {
    
    @IBOutlet weak var toDoListTable: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tasksDueToday: UILabel!
    @IBOutlet weak var tasksDueThisWeek: UILabel!
    @IBOutlet weak var tasksDone: UILabel!

    
    // Properties
    var usersName:String = ""
    //private var tableList = [String]() //items in table
    private var todaysTaskList = [Task]()
    private var weekTaskList = [Task]()  
    private var completedAssignmentCount = 0
    private var toDoThisWeek = 0
    private var toDoToday = 0
    
    let transition = SlideInTransition()

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
        return(todaysTaskList.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == toDoListTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "toDoListItem", for: indexPath) as! HomeTableViewCell
            
            cell.toDoListItemLabel.text = todaysTaskList[indexPath.row].getName()
            cell.setAssignmentName(name: todaysTaskList[indexPath.row].getName())
            cell.setDueDate(date: todaysTaskList[indexPath.row].getDueDate())
            cell.setCourseName(course: todaysTaskList[indexPath.row].getCourseName())
            cell.setDivisionType(division: todaysTaskList[indexPath.row].getDivisionType())
            
            if todaysTaskList[indexPath.row].getStatus() == "complete" {
                cell.toDoListCheckButton.setBackgroundImage(UIImage(named: "icons8-checkmark-30"), for: .normal)
            }
            
            cell.selectionDelegate = self
            
            return cell
        }
        
        return UITableViewCell()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // update table view
        DispatchQueue.main.async {
            self.toDoListTable.reloadData()
        }
        
        // update labels for completion
        self.tasksDueToday.text = "\(self.toDoToday)"
        self.tasksDone.text = "\(self.completedAssignmentCount)"
        self.tasksDueThisWeek.text = "\(self.toDoThisWeek)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoListTable.dataSource = self
        toDoListTable.delegate = self
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

                                        var dueDate = greatGrandChildSnapshot.childSnapshot(forPath: "due date").value as? String ?? "NA inputted"
                                        
                                        // if user did not enter date
                                        if dueDate == "NA inputted" {
                                            break
                                        }
                                        
                                        dueDate = self.formatDate(adate: dueDate)

                                        if dueDate == currentDateShort {//|| dueDate == "NA inputted"{
//                                            let task = Task(dueDate: dueDate, name: assignmentName, isComplete: status, courseName: courseName, divisionType: divisionType)
//                                           // self.tableList.append(assignmentName)
//                                            self.todaysTaskList.append(task)
                                            self.toDoToday += 1

                                        }
                                        
                                        let date = self.stringToDate(dateString: dueDate)
                                        
                                        // get start and end of week
                                        let sunday = self.getSunday(myDate: date)
                                        let saturday = self.getSaturday(myDate: date)
                                        
                                        if (sunday ... saturday).contains(date) {
                                            let task = Task(dueDate: dueDate, name: assignmentName, isComplete: status, courseName: courseName, divisionType: divisionType)
                                            self.todaysTaskList.append(task)
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
            
            self.createObservers()

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
        print("her121e \(dateString)")
        let date = dateFormatterGet.date(from: dateString)
        
        return date!
    }
    
    
    let add = Notification.Name(rawValue: taskAddedNotificationKey)
    // housekeeping
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func createObservers() {
        // Task Added
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.updateTableList(notification:)), name: add, object: nil)
    }
    
    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.didTapMenuType = { menuType in
            print(menuType)
            if(menuType == .logout) {
                self.performSegue(withIdentifier: "logout", sender: self)
                return
            }
            //self.transitionToNew(menuType)
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
//    func transitionToNew(_ menuType: MenuType) {
//        
//        switch menuType {
//        case .logout:
//            self.performSegue(withIdentifier: "logout", sender: self)
//            
//        case .home:
//            print("boop")
// //           let view = UIView()
////            view.
////        default:
////
//        }
//    }
    @objc func updateTableList(notification: NSNotification) {
        
        // if the notification for the occasion that a Task added is posted
        if notification.name == add {
            // try to get the Task passed
            if let task = notification.userInfo?["task"] as? Task{
                
                // get current date
                let date = Date()
                let format = DateFormatter()
                format.dateStyle = .short
                let currentDateShort = format.string(from:date)
                
                // analyze the task for relations to the current date
                print(" this is the due \(task.getDueDate())")
                
                if(self.formatDate(adate: task.getDueDate()) == currentDateShort) {
                    //todaysTaskList.append(task)
                    self.toDoToday += 1
                    //self.toDoThisWeek += 1
                }
                
                let adate = self.stringToDate(dateString: task.getDueDate())
                
                // get start and end of week
                let sunday = self.getSunday(myDate: adate)
                let saturday = self.getSaturday(myDate: adate)
                
                if (sunday ... saturday).contains(adate) {
                    self.todaysTaskList.append(task)
                    self.toDoThisWeek += 1
                }
                
                if(task.getStatus() == "complete") {
                    self.completedAssignmentCount += 1
                }
                
            }

        }
        
    }
    
    //if date is not in format .short
    func formatDate(adate: String) -> String {
        var unformattedDate = adate
        var dateStringArray = [String]()
        
        while unformattedDate.count != 0 {
            dateStringArray.append(String(unformattedDate.remove(at: unformattedDate.startIndex)))
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
        
        var formattedDate = ""
        for element in dateStringArray {
            formattedDate += String(element)
        }

        return formattedDate
    }

}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
