//
//  DataEntryViewController.swift
//  PlanX
//
//  Created by Roshini  Malempati  on 7/22/19.
//  Copyright © 2019 H2OT. All rights reserved.
//

import UIKit

class DataEntryViewController: UIViewController {

    // variables
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var userEntryTxt: UITextView!
    @IBOutlet weak var storeEntry: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if storeEntry.isSelected == true {
            
            // change view
            performSegue(withIdentifier: "CalDateStorage", sender: self)
        }
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
