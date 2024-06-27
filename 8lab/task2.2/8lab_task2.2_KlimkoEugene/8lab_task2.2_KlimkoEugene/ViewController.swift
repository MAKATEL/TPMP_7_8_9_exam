//
//  ViewController.swift
//  8lab_task2.2_KlimkoEugene
//
//  Created by MacOSExi on 16.05.24.
//  Copyright © 2024 MacOSExi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Рисуем криволинейный треугольник
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 150, y: 100))
        trianglePath.addQuadCurve(to: CGPoint(x: 200, y: 200), controlPoint: CGPoint(x: 185, y: 150))
        trianglePath.addQuadCurve(to: CGPoint(x: 100, y: 200), controlPoint: CGPoint(x: 150, y: 250))
        trianglePath.addQuadCurve(to: CGPoint(x: 150, y: 100), controlPoint: CGPoint(x: 125, y: 125))
        trianglePath.close()
        let triangle = CAShapeLayer()
        triangle.path = trianglePath.cgPath
        triangle.fillColor = UIColor.purple.cgColor
        
        // Рисуем шестиугольник
        let hexagon = CAShapeLayer()
        hexagon.path = hexagonPathWithCenter(center: CGPoint(x: 200, y: 400), radius: 50).cgPath
        hexagon.fillColor = UIColor.orange.cgColor
        
        let frame = CGRect(x: 0, y: 0, width: 500, height: 500)
        
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [UIColor.blue.cgColor, UIColor.yellow.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.mask = triangle
        
        let shadow = CAShapeLayer()
        shadow.path = hexagon.path
        shadow.shadowColor = UIColor.black.cgColor
        shadow.shadowOffset = CGSize(width: 3.0, height: 10)
        shadow.shadowOpacity = 1.0
        shadow.shadowRadius = 6
        shadow.rasterizationScale = UIScreen.main.scale
        
        self.view.layer.addSublayer(gradient)
        self.view.layer.addSublayer(shadow)
        // Do any additional setup after loading the view.
    }

    func hexagonPathWithCenter(center: CGPoint, radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        for i in 0..<6 {
            let angle = CGFloat(Double.pi / 3.0 * Double(i))
            let x = center.x + radius * cos(angle)
            let y = center.y + radius * sin(angle)
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        path.close()
        return path
    }
}
