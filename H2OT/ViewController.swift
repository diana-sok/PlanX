//
//  ViewController.swift
//  H2OT
//
//  Created by admin on 7/12/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var monthButtons: [UIButton]!
    
    @IBOutlet weak var Calendar: UICollectionView!
    
    @IBOutlet weak var MonthLabel: UILabel!
    
    let monthsInYr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    let daysOfMonths = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var daysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    var currentMonth = String()
    
    var numOfEmptyBoxes = Int() //  the number of empty boxes at the start of the current month
    
    var direction = 0 // = 0 if in current month, = 1 if in furture month, = -1 if in previous month
    
    var posIndex = 0 //  where values will be stored about the empty boxes
    
    var leapYrCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        currentMonth = monthsInYr[month]
        
        MonthLabel.text = "\(currentMonth) \(year)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getStartDateDayPos() {
        switch direction {
        case 0:
            switch day {
            case 1...7:
                numOfEmptyBoxes = weekday - day
            case 8...14:
                numOfEmptyBoxes = weekday - day - 7
            case 15...21:
                numOfEmptyBoxes = weekday - day - 14
            case 22...28:
                numOfEmptyBoxes = weekday - day - 21
            case 29...31:
                numOfEmptyBoxes = weekday - day - 28
            default:
                break
            }
            posIndex = numOfEmptyBoxes
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return daysInMonths[month]
        /*switch direction {
        case 0:
            return daysInMonths[month] + numOfEmptyBoxes
        default:
            fatalError()
        }*/
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath) as! DataCollectionViewCell
        
        cell.backgroundColor = UIColor.clear
        
        cell.DateLabel.textColor = UIColor.black
        
        // cell.DateLabel.text = "\(indexPath.row + 1)"
        
        switch direction {
        case 0:
            cell.DateLabel.text = "\(indexPath.row + 1 - numOfEmptyBoxes)"
        default:
            fatalError()
        }
        
        switch indexPath.row {
        case 5, 6, 12, 13, 19, 20, 26, 27:
            if Int(cell.DateLabel.text!)! > 0 {
                cell.DateLabel.textColor = UIColor.lightGray
            }
        default:
            break
        }
        
        // mark the current date cell as light blue
        if currentMonth == monthsInYr[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 == day {
            cell.backgroundColor = UIColor.cyan
        }
        
        return cell
    }
    

    @IBAction func handleSelection(_ sender: UIButton) {
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
    
    @IBAction func cityTapped(_ sender: UIButton) {
        
        guard let title = sender.currentTitle, let monthChosen = Months(rawValue: title) else {
            return
        }
        
        switch monthChosen {
        case .January:
            // print("Jan")
            month = 0
            direction = 0
            //getStartDateDayPos()
            month = 0
            currentMonth = monthsInYr[month]
            MonthLabel.text = "\(monthChosen) \(year)"
        case .February:
            // print("Feb")
            month = 1
            direction = 0
            if leapYrCount > 0 {
                leapYrCount -= 1
            }
            
            if leapYrCount == 0 {
                daysInMonths[1] = 29
                leapYrCount = 4
            }
            else {
                daysInMonths[1] = 28
            }
            
            if leapYrCount < 5 {
                leapYrCount += 1
            }
            
            if leapYrCount == 4 {
                daysInMonths[1] = 29
            }
            
            if(leapYrCount == 5) {
                daysInMonths[1] = 28
            }
            //getStartDateDayPos()
            month = 1
            currentMonth = monthsInYr[month]
            MonthLabel.text = "\(monthChosen) \(year)"
        case .March:
            // print("Mar")
            month = 2
            direction = 0
            //getStartDateDayPos()
            month = 2
            currentMonth = monthsInYr[month]
            MonthLabel.text = "\(monthChosen) \(year)"
        case .April:
            // print("Apr")
            month = 3
            direction = 0
            //getStartDateDayPos()
            month = 3
            currentMonth = monthsInYr[month]
            MonthLabel.text = "\(monthChosen) \(year)"
        case .May:
            // print("May")
            month = 4
            direction = 0
            //getStartDateDayPos()
            month = 4
            currentMonth = monthsInYr[month]
            MonthLabel.text = "\(monthChosen) \(year)"
        case .June:
            // print("Jun")
            month = 5
            direction = 0
            //getStartDateDayPos()
            month = 5
            currentMonth = monthsInYr[month]
            MonthLabel.text = "\(monthChosen) \(year)"
        case .July:
            // print("Jul")
            month = 6
            direction = 0
            //getStartDateDayPos()
            month = 6
            currentMonth = monthsInYr[month]
            MonthLabel.text = "\(monthChosen) \(year)"
        case .August:
            // print("Aug")
            month = 7
            direction = 0
           // getStartDateDayPos()
            month = 7
            currentMonth = monthsInYr[month]
            MonthLabel.text = "\(monthChosen) \(year)"
        case .September:
            // print("Sep")
            month = 8
            direction = 0
            //getStartDateDayPos()
            month = 8
            currentMonth = monthsInYr[month]
            MonthLabel.text = "\(monthChosen) \(year)"
        case .October:
            // print("Oct")
            month = 9
            direction = 0
           // getStartDateDayPos()
            month = 9
            currentMonth = monthsInYr[month]
            MonthLabel.text = "\(monthChosen) \(year)"
        case .November:
            // print("Nov")
            month = 10
            direction = 0
            //getStartDateDayPos()
            month = 10
            currentMonth = monthsInYr[month]
            MonthLabel.text = "\(monthChosen) \(year)"
        default:
            // print("Dec")
            month = 11
            direction = 0
            //getStartDateDayPos()
            month = 11
            currentMonth = monthsInYr[month]
            MonthLabel.text = "\(monthChosen) \(year)"
        }
        
        
        Calendar.reloadData()
        
    }
    
}

