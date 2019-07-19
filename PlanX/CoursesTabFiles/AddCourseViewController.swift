//
//  AddCourseViewController.swift
//  PlanX CoursesTab
//
//  Created by admin on 7/10/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class AddCourseViewController: UIViewController {
    
    @IBOutlet weak var courseName: UITextField!
    
    @IBAction func addCourseButton(_ sender: AnyObject) {
        if (courseName.text != ""){
            list.append(courseName.text!)
            courseName.text = "";
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
