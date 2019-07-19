//
//  ViewController.swift
//  H2OT
//
//  Created by admin on 7/12/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

var dateString = ""

class CalendarsTabViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // variables
    @IBOutlet weak var Calendar: UICollectionView!
    
    @IBOutlet weak var MonthLabel: UILabel!
    
    let monthsInYr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    let daysOfMonths = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var daysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    var currentMonth = String()
    
    var numOfEmptyBoxes = Int() //  the number of empty boxes at the start of the current month
    
    var nextNumEmptyBox = Int()
    
    var prevNumEmptyBox = 0
    
    var direction = 0 // = 0 if in current month, = 1 if in furture month, = -1 if in previous month
    
    var posIndex = 0 //  where values will be stored about the empty boxes
    
    var leapYrCount = 1
    
    var arrayofCells : [UICollectionViewCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // when the calendar tab loads show the current month
        currentMonth = monthsInYr[month]
        
        // the label for the month that is shown
        MonthLabel.text = "\(currentMonth) \(year)"
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
        case 1...:
            nextNumEmptyBox = (posIndex + daysInMonths[month])%7
            posIndex = nextNumEmptyBox
        case -1:
            prevNumEmptyBox = (7 - (daysInMonths[month] - posIndex)%7)
            if prevNumEmptyBox == 7 {
                prevNumEmptyBox = 0
            }
            posIndex = prevNumEmptyBox
        default:
            fatalError()
        }
    }
    
    
    @IBAction func NextMonthButton(_ sender: UIButton) {
        // change the months as arrows are clicked
        // month += 1
        if currentMonth == "December" {
            month = 0
            year += 1
            direction = 1
            
            // determine if its a leap year or not
            if leapYrCount < 5 {
                leapYrCount += 1
            }
            
            if leapYrCount == 4 {
                daysInMonths[1] = 29
            }
            
            if leapYrCount == 5 {
                leapYrCount = 1
                daysInMonths[1] = 28
            }
            
            getStartDateDayPos()
            currentMonth = monthsInYr[month]
            
            // rewrite the label for calendar
            MonthLabel.text = "\(currentMonth) \(year)"
            
            moveMonthLabelForward(Label: MonthLabel)
            
            // reload Calendar
            Calendar.reloadData()
        }
        direction = 1
        getStartDateDayPos()
        
        month += 1
        
        currentMonth = monthsInYr[month]
        
        // rewrite the label for calendar
        MonthLabel.text = "\(currentMonth) \(year)"
        
        moveMonthLabelForward(Label: MonthLabel)
        
        // reload Calendar
        Calendar.reloadData()
    }
    
    @IBAction func PrevMonthButton(_ sender: UIButton) {
        // change months as arrows are clicked
        // month -= 1
        if currentMonth == "January" {
            month = 11
            year -= 1
            direction = -1;
            
            // determine if its a leap year or not
            if leapYrCount > 0 {
                leapYrCount -= 1
            }
            
            if leapYrCount == 0 {
                daysInMonths[1] = 29
                leapYrCount = 4
            } else {
                daysInMonths[1] = 28
            }
            
            getStartDateDayPos()
            currentMonth = monthsInYr[month]
            
            // rewrite label for the calendar
            MonthLabel.text = "\(currentMonth) \(year)"
            
            moveMonthLabelBackward(Label: MonthLabel)
            
            // reload Calendar
            Calendar.reloadData()
        }
        direction = -1
        getStartDateDayPos()
        month -= 1
        currentMonth = monthsInYr[month]
        
        // rewrite label for the calendar
        MonthLabel.text = "\(currentMonth) \(year)"
        
        moveMonthLabelBackward(Label: MonthLabel)
        
        // reload Calendar
        Calendar.reloadData()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return daysInMonths[month]
        switch direction {
        case 0:
            return daysInMonths[month] + numOfEmptyBoxes
        case 1...:
            return daysInMonths[month] + nextNumEmptyBox
        case -1:
            return daysInMonths[month] + prevNumEmptyBox
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath) as! DataCollectionViewCell
        
        cell.backgroundColor = UIColor.clear
        cell.DateLabel.textColor = UIColor.black
        
        cell.DateView.isHidden = true
        
        // check if cell is hidden or not
        if cell.isHidden {
            cell.isHidden = false
        }
        
        // cell.DateLabel.text = "\(indexPath.row + 1)"
        
        switch direction {
        case 0:
            cell.DateLabel.text = "\(indexPath.row + 1 - numOfEmptyBoxes)"
        case 1...:
            cell.DateLabel.text = "\(indexPath.row + 1 - nextNumEmptyBox)"
        case -1:
            cell.DateLabel.text = "\(indexPath.row + 1 - prevNumEmptyBox)"
        default:
            fatalError()
        }
        
        // hide the cells so that the month starts off at the right day
        if Int(cell.DateLabel.text!)! < 1 {
            cell.isHidden = true
        }
        
        // change the font for the weekends of the calendar to gray
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
            //cell.backgroundColor = UIColor.cyan
            // create a circle for the current cell date
            // this was an attempt to draw a circle around the box but instead a border was created which still looked good so was kept as that
            cell.DateView.isHidden = false
            cell.DateView.layer.backgroundColor = UIColor.cyan.cgColor
            //cell.DrawCircle()
            
        }
        
        arrayofCells.append(cell)
        return cell
    }
    
    // adds animation to the cells and makes them show up a just a bit later than the month
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        
        for x in arrayofCells {
            let cell : UICollectionViewCell = x
            
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
                cell.alpha = 1
                cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
            })
        }
    }
    
    // show the cells date title in table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
            as! DateStorageTableViewCell
        
        cell.ClndrStrDateLabel.text = dateString
        
        return cell
    }
    
    // when you select a cell - the cell color will change
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cells = collectionView.cellForItem(at: indexPath)
        cells?.backgroundColor = UIColor.blue
        
        // if current date is selected then change the color to blue
        if currentMonth == monthsInYr[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 == day {
            cells?.backgroundColor = UIColor.blue
        }
         
        dateString = "\(indexPath.row - posIndex + 1) \(currentMonth) \(year)"
        // print(dateString)
        
        performSegue(withIdentifier: "CalDateStorage", sender: self)
        
    }
    
    // when you deselct a cell - the color goes back to its original color
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.clear
        
    }
    
    
}

