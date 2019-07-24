//
//  DataCollectionViewCell.swift
//  H2OT
//
//  Created by admin on 7/12/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class DataCollectionViewCell: UICollectionViewCell {
    
    // variables
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var DateView: UIView!
    
    func DrawCircle() {
        
        // this was an attempt to draw a circle around the box
        let circleCenter = DateView.center
        
        let circlePath = UIBezierPath(arcCenter: circleCenter, radius: (DateView.bounds.width/2 - 5), startAngle: -CGFloat.pi/2, endAngle: 2*CGFloat.pi, clockwise: true)
        
        let circleLayer = CAShapeLayer()
        
        circleLayer.path = circlePath.cgPath
        
        circleLayer.strokeColor = UIColor.cyan.cgColor
        
        circleLayer.lineWidth = 2
        
        circleLayer.strokeEnd = 0
        
        circleLayer.fillColor = UIColor.cyan.cgColor
        
        circleLayer.lineCap = CAShapeLayerLineCap.round
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        animation.duration = 1.5
        
        animation.toValue = 1
        
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        animation.isRemovedOnCompletion = false
        
        circleLayer.add(animation, forKey: nil)
        
        DateView.layer.addSublayer(circleLayer)
        
        DateView.layer.backgroundColor = UIColor.clear.cgColor
        
    }
    
}
