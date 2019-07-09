//
//  CalendarVariables.swift
//  H2OT
//
//  Created by admin on 7/5/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

let date = Date()

let calendar = Calendar.current

let day = calendar.component(.day, from: date)
let weekday = calendar.component(.weekday, from: date)
let month = calendar.component(.month, from: date)
let year = calendar.component(.year, from: date)


