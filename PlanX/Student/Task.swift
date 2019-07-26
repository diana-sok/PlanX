//
//  Task.swift
//  PlanX
//
//  Created by Diana Sok on 7/15/19.
//  Copyright © 2019 H2OT. All rights reserved.
//

import Foundation

class Task {
    
    private var dueDate:String
    private var name:String
    private var score:Double
    private var isComplete:String
    private var courseName:String
    private var divisionType:String
    
    // Constructors
    init(dueDate:String, name:String, score:Double, isComplete:String, courseName:String, divisionType:String) {
        self.dueDate = dueDate
        self.name = name
        self.score = score
        self.isComplete = isComplete
        self.courseName = courseName
        self.divisionType = divisionType
    }
    
    init(dueDate:String, name:String, isComplete:String, courseName:String, divisionType:String) {
        self.dueDate = dueDate
        self.name = name
        self.score = -1
        self.isComplete = isComplete
        self.courseName = courseName
        self.divisionType = divisionType
    }
    
    init(name:String, isComplete:String, courseName:String, divisionType:String) {
        self.dueDate = "none inputted"
        self.name = name
        self.score = -1
        self.isComplete = isComplete
        self.courseName = courseName
        self.divisionType = divisionType
    }
    
    // Setters
    func setDueDate(dueDate:String) {
        self.dueDate = dueDate
    }
    
    func setName(name:String) {
        self.name = name
    }
    
    func setScore(score:Double) {
        self.score = score
    }
    
    func setCompleteness(isComplete:String) {
        self.isComplete = isComplete
    }
    
    // Getters
    func getDueDate() -> String {
        return dueDate
    }
    
    func getName() -> String {
        return name
    }
    
    func getScore() -> Double {
        return score
    }
    
    func getCourseName() -> String {
        return courseName
    }
    
    func getDivisionType() -> String {
        return divisionType
    }
    
    func getStatus() -> String {
        return isComplete
    }
    
    // Methods to design
    
}
