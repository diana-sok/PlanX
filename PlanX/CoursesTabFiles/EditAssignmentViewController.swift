//
//  EditAssignmentViewController.swift
//  PlanX CoursesTab
//
//  Created by admin on 7/14/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class EditAssignmentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveAssignmentButton(_ sender: Any) {
        
        // read through database
        // create an instance of the current stuff and name it "old"
        // create a new instance of the new info/change the stuff changed
        // delete the old one and create a new one
        // ex.new assignment name -> change the name globally & on database
        
        performSegue(withIdentifier: "assignmentSaved", sender: self)
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
