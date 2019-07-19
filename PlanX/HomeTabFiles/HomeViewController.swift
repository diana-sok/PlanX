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
    
    var usersName:String = ""
    //items in table
    let list = ["Milk", "Honey", "Bread", "Tacos"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(list.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoListItem", for: indexPath) as! HomeTableViewCell
        cell.toDoListItemLabel.text = list[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        let date = Date()
        let format = DateFormatter()
        format.dateStyle = .full
        let formattedDate = format.string(from: date)
        self.dateLabel.text = formattedDate

        //how to access children of a node example:
        let coursesRef = Database.database().reference().child("someid").child("Courses")
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
                            print("  --distribution")
                            print("  \(grandChildSnapshot.key as String)")
                            print("  --")
                            for greatGrandChild in grandChildSnapshot.children {
                                if let greatGrandChildSnapshot = greatGrandChild as? DataSnapshot {
                                    print("    --assignment")
                                    print("    \(greatGrandChildSnapshot.key as String)")
                                    let k = greatGrandChildSnapshot.key as String
                                    if(k != "Percentage") {
                                        //let v = greatGrandChildSnapshot.value as? NSDictionary
                                        //v.value?["due date"] as? String ?? ""
                                    }
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
    
        })
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
}

