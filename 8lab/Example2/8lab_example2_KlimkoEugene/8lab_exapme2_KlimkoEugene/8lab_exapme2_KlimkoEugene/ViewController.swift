//
//  ViewController.swift
//  8lab_exapme2_KlimkoEugene
//
//  Created by MacOSExi on 16.05.24.
//  Copyright © 2024 MacOSExi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let squarePath = UIBezierPath()
        squarePath.move(to: CGPoint(x: 100, y: 100))
        squarePath.addLine(to: CGPoint(x: 200, y: 100))
        squarePath.addLine(to: CGPoint(x: 200, y: 200))
        squarePath.addLine(to: CGPoint(x: 100, y: 200))
        
        squarePath.close()
        
        let square = CAShapeLayer()
        square.path = squarePath.cgPath
        square.fillColor = UIColor.blue.cgColor
        self.view.layer.addSublayer(square)
        
        let circle = CAShapeLayer()
        circle.path = circlePathWithCenter(center: CGPoint(x: 200, y: 400), radius: 50).cgPath
        circle.fillColor = UIColor.red.cgColor
        self.view.layer.addSublayer(circle)
        // Do any additional setup after loading the view.
    }

    
    func circlePathWithCenter(center: CGPoint, radius: CGFloat) -> UIBezierPath {
        let ans = UIBezierPath()
        ans.addArc(withCenter: center, radius: radius, startAngle: -CGFloat(Double.pi), endAngle: -CGFloat(-Double.pi), clockwise: true)
        ans.close()
        return ans;
    }

}


