//
//  DataStorageViewController.swift
//  PlanX
//
//  Created by Diana Sok on 7/29/19.
//  Copyright © 2019 H2OT. All rights reserved.
//

import UIKit

class DataStorageViewController: UIViewController, SingleDayTapped, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var assignmentsTable: UITableView!
    @IBOutlet weak var CalDataStorageLbl: UILabel!
    private var assignmentsDueToday: [Task] = [Task]()
    
    override func viewWillAppear(_ animated: Bool) {
        assignmentsTable.reloadData()
        for a in assignmentsDueToday {
            print("bloop \(a.getName())")
        }
       // assignmentsTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignmentsTable.delegate = self
        assignmentsTable.dataSource = self
        CalDataStorageLbl.text = dateString
        assignmentsTable.reloadData()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("please work \(assignmentsDueToday.count)")
        return assignmentsDueToday.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == assignmentsTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "toDo", for: indexPath) as! DataStorageTableViewCell
            cell.assignmentName.text = assignmentsDueToday[indexPath.row].getName() + "  (" +  "\(assignmentsDueToday[indexPath.row].getCourseName())" + ")"
            return cell
        }
        return UITableViewCell()
    }
    
    func singleDayTapped(assignments: [Task]) {
        let date = stringToDate(dateString: dateString)
        
        // convert date to string of format MM/DD/YY
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: date)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "MM/dd/YY"
        let myStringafd = formatter.string(from: yourDate!)
        
        print("WOHHOOOOOOOO")
        for element in assignments {
            if element.getDueDate() == myStringafd {
                print("WOHHOOOOOOOO")
                print(element.getName())
                assignmentsDueToday.append(element)
                //assignmentsTable.reloadData()
            }
            //assignmentsTable.reloadData()
        }
        
        
    }
    
    func stringToDate(dateString: String) -> Date {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd MMMM yyyy"
        print("her121e \(dateString)")
        let date = dateFormatterGet.date(from: dateString)
        
        return date!
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
