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
    
    private var _firstName:String
    var firstName:String {
        get {
//            return lockQueue.sync {
//                print("hi \(_firstName)")
//                return _firstName
//            }
            return lockQueue.sync {
                 _firstName
                //firstName = _firstName
            }
            //return _firstName
        }
        
        set {
//            lockQueue.sync {
//                print("setq")
//                _firstName = newValue
//            }
            lockQueue.async(flags: .barrier) {
                self._firstName = newValue
                
            }
        }
    }
    
    private var _lastName:String
    var lastName:String {
        get {
            return lockQueue.sync {
                print(_lastName)
                return _lastName
            }
        }
        
        set {
            lockQueue.sync {
                print("sethhh")
                _firstName = newValue
            }
        }
    }
    private var _courses:[Course]
    
//    private let lockQueue = DispatchQueue(label: "MySingleton.lockQueue")
    private let lockQueue = DispatchQueue(label: "SingletionInternalQueue", qos: .default, attributes: .concurrent)
   // private var uid:String          //unique UID of this user

    
    
//    var name: String {
//        get {
//            return internalQueue.sync {firstName + lastName}
//        }
//        set (theName) {
//            internalQueue.async(flags: .barrier) { self.lastName = theName }
//        }
//    }
//
//    func setup(string: String) {
//        name = string
//    }
    
    // Constructors
    private init() {
        self._firstName = ""
        self._lastName = ""
        //uid = ""
        _courses = []
    }
    //this may be removied:
    private init(firstName:String, lastName:String) {
        self._firstName = firstName
        self._lastName = lastName
        //uid = Auth.auth().currentUser!.uid
        _courses = []
    }
    
    // Setters
    func setFirstName(firstName:String) {
        //internalQueue.async(flags: .barrier) { self.firstName = firstName }
        self._firstName = firstName
        print("cool \(self._firstName)")
    }
    
    func setLastName(lastName:String) {
        //internalQueue.async(flags: .barrier) { self.lastName = lastName }
        self._lastName = lastName
        print("wow \(self._lastName)")
    }
    
//    func setUID() {
//        uid = Auth.auth().currentUser!.uid
//    }

    // Getters
    func getName() -> String {
        var name:String = self._firstName
        name += self._lastName
        return name
       // return internalQueue.sync {firstName + lastName}
    }
    
    func getFirstName() -> String {
        return self._firstName
    }
    
    func getLastName() -> String {
        return self._lastName
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
