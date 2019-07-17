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
    private var isComplete:Bool 
    
    // Constructors
    init(dueDate:String, name:String, score:Double, isComplete:Bool) {
        self.dueDate = dueDate
        self.name = name
        self.score = score
        self.isComplete = isComplete
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
    
    func setCompleteness(isComplete:Bool) {
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
    
    func isCompleted() -> Bool {
        return isComplete
    }
    
    // Methods to design
    
}
