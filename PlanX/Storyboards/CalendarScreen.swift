//
//  CalendarScreen.swift
//  H2OT
//
//  Created by admin on 7/2/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class CalendarScreen: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // this is just for UI of calendar and drop down menu for selection of months
    // variables
    @IBOutlet var monthButtons: [UIButton]!
    
    @IBOutlet weak var Calendar: UICollectionView!
    
    let monthsInYr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    let daysOfMonths = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var daysInMonths = [30, 28, 31]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // collection of dates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func hadleSelection(_ sender: UIButton) {
        monthButtons.forEach { (buttons) in
            UIView.animate(withDuration: 0.3, animations: {
                buttons.isHidden = !buttons.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    enum Months: String {
        case January = "January"
        case February = "February"
        case March = "March"
        case April = "April"
        case May = "May"
        case June = "June"
        case July = "July"
        case August = "August"
        case September = "September"
        case October = "October"
        case November = "November"
        case December = "December"
    }
    
    @IBAction func monthTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle, let month = Months(rawValue: title) else {
                return
        }
        
        switch month {
        case .January:
            print("Jan")
        case .February:
            print("Feb")
        case .March:
            print("Mar")
        case .April:
            print("Apr")
        case .May:
            print("May")
        case .June:
            print("Jun")
        case .July:
            print("Jul")
        case .August:
            print("Aug")
        case .September:
            print("Sep")
        case .October:
            print("Oct")
        case .November:
            print("Nov")
        default:
            print("Dec")
        }
    }
    
    // starting from here - code for the dates where something is to be stored
    
    
}
