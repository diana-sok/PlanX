//
//  CourseDivision.swift
//  PlanX
//
//  Created by Diana Sok on 7/15/19.
//  Copyright © 2019 H2OT. All rights reserved.
//

//singleton pattern
import Foundation

class CourseDivision {
    private var divisionType:String = "" //Test, Homework etc
    private var percentOfWhole:Double = 0 //30% of course grade //double or int
    private var tasks:[Task] = []
    
    //Constructors
    init(divisionType:String, percentOfWhole:Double) {
        self.divisionType = divisionType
        self.percentOfWhole = percentOfWhole
        tasks = []
    }
    
    init(divisionType:String, percentOfWhole:Double, tasks:[Task]) {
        self.divisionType = divisionType
        self.percentOfWhole = percentOfWhole
        self.tasks = tasks
    }
    
    // Getters
    func getDivisionType() -> String {
        return divisionType
    }
    
    func getPercentOfWhole() -> Double {
        return percentOfWhole
    }
    
    func getTasks() -> [Task] {
        return tasks
    }
    
    func getNumberOfTasks() -> Int{
        return tasks.count
    }
    
    //Setters
    func setDivisionType(divisionType:String) {
        self.divisionType = divisionType
    }
    
    func setPercentOfWhole(percentOfWhole:Double) {
        self.percentOfWhole = percentOfWhole
    }
    
    func setTasks(tasks:[Task]) {
        self.tasks = tasks
    }
    
    // Methods
    func addTask(aTask:Task) {
        tasks.append(aTask)
    }
    
    // Methods to design
    func removeTask(taskName:String) {
        
    }
}
