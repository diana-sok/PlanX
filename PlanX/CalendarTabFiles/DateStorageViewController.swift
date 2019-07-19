//
//  DateStorageViewController.swift
//  PlanX
//
//  Created by Roshini  Malempati  on 7/18/19.
//  Copyright © 2019 H2OT. All rights reserved.
//

import UIKit

class DateStorageViewController: UIViewController {

    @IBOutlet weak var CalStrgDateLbl: UILabel!
    
    @IBOutlet weak var DataStrgLocals: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        CalStrgDateLbl.text = dateString
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
