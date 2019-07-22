//
//  Student.swift
//  PlanX
//
//  Created by Diana Sok on 7/15/19.
//  Copyright © 2019 H2OT. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

//for use in singleton pattern?!?
//private let sharedInstance = Student(firstName: "hello", lastName: "me")

class Student {
    
    static let sharedInstance = Student()
    
    private var firstName:String
    private var lastName:String
   // private var uid:String          //unique UID of this user
    private var courses:[Course]
    
    // Constructors
    private init() {
        self.firstName = ""
        self.lastName = ""
        //uid = ""
        courses = []
    }
    //this may be removied:
    private init(firstName:String, lastName:String) {
        self.firstName = firstName
        self.lastName = lastName
        //uid = Auth.auth().currentUser!.uid
        courses = []
    }
    
    // Setters
    func setFirstName(firstName:String) {
        self.firstName = firstName
        print("cool \(self.firstName)")
    }
    
    func setLastName(lastName:String) {
        self.lastName = lastName
        print("wow \(self.lastName)")
    }
    
//    func setUID() {
//        uid = Auth.auth().currentUser!.uid
//    }

    // Getters
    func getName() -> String {
        return firstName + lastName
    }
    
    func getUID() -> String {
        return Auth.auth().currentUser!.uid
    }
    
    // Methods to design:
    func addCourse() {
        
    }
    
    func removeCourse() {
        
    }
    
    func addTaskToCourse() {
        
    }
    
    func removeTaskFromCourse() {
        
    }
    
    func editTaskOfCourse() {
        
    }
    
}
