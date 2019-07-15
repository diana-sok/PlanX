//
//  SettingsViewController.swift
//  PlanX
//
//  Created by Diana Sok on 7/7/19.
//  Copyright © 2019 H2OT. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth


class SettingsViewController: UIViewController {
    
    @IBOutlet weak var signOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    @IBAction func signOutButtonTapped(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            // self.performSeg
            self.performSegue(withIdentifier: "goToNext", sender: self)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}
