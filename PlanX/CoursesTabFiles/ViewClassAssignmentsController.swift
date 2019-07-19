//
//  ViewClassAssignmentsController.swift
//  PlanX CoursesTab
//
//  Created by admin on 7/11/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

var items = ["Assignment 1", "Assignment 2", "Assignment 3", "Exam 1", "Project 1"]

class ViewClassAssignmentsController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    //Number if items to display
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (items.count)
    }

    //What to display
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "assignmentCell")
        cell.textLabel?.text = items[indexPath.row]
        return(cell)
    }
    
    //Deletes list items
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            items.remove(at: indexPath.row)
            itemsTableView.reloadData()
        }
    }
    
    //Refreshes the list
    override func viewDidAppear(_ animated: Bool) {
        itemsTableView.reloadData()
    }
    
    //Clickable table items
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        performSegue(withIdentifier: "assignmentDetailSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = list[myIndex]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
