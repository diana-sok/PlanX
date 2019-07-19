//
//  CalendarAnimations.swift
//  PlanX
//
//  Created by Roshini  Malempati  on 7/18/19.
//  Copyright © 2019 H2OT. All rights reserved.
//

import UIKit

func moveMonthLabelForward(Label: UILabel) {
    let posAnim = CABasicAnimation(keyPath: "position")
    posAnim.fromValue = NSValue(cgPoint: CGPoint(x: Label.center.x + 50, y: Label.center.y))
    posAnim.toValue = NSValue(cgPoint: CGPoint(x: Label.center.x, y: Label.center.y))
    posAnim.duration = 0.4
    
    let fadeAnim = CABasicAnimation(keyPath: "opacity")
    fadeAnim.fromValue = 0
    fadeAnim.toValue = 1
    fadeAnim.duration = 0.4
    
    Label.layer.add(posAnim, forKey: nil)
    Label.layer.add(fadeAnim, forKey: nil)
}

func moveMonthLabelBackward(Label: UILabel) {
    let posAnim = CABasicAnimation(keyPath: "position")
    posAnim.fromValue = NSValue(cgPoint: CGPoint(x: Label.center.x - 50, y: Label.center.y))
    posAnim.toValue = NSValue(cgPoint: CGPoint(x: Label.center.x, y: Label.center.y))
    posAnim.duration = 0.4
    
    let fadeAnim = CABasicAnimation(keyPath: "opacity")
    fadeAnim.fromValue = 0
    fadeAnim.toValue = 1
    fadeAnim.duration = 0.4
    
    Label.layer.add(posAnim, forKey: nil)
    Label.layer.add(fadeAnim, forKey: nil)
}
