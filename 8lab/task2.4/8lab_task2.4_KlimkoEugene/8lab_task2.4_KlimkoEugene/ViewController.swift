//
//  ViewController.swift
//  8lab_task2.4_KlimkoEugene
//
//  Created by MacOSExi on 16.05.24.
//  Copyright © 2024 MacOSExi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var triangle = CAShapeLayer()
    var hexagon = CAShapeLayer()
    var shadow = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Рисуем криволинейный треугольник
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 150, y: 100))
        trianglePath.addQuadCurve(to: CGPoint(x: 200, y: 200), controlPoint: CGPoint(x: 185, y: 150))
        trianglePath.addQuadCurve(to: CGPoint(x: 100, y: 200), controlPoint: CGPoint(x: 150, y: 250))
        trianglePath.addQuadCurve(to: CGPoint(x: 150, y: 100), controlPoint: CGPoint(x: 125, y: 125))
        trianglePath.close()
        
        triangle.path = trianglePath.cgPath
        triangle.fillColor = UIColor.orange.cgColor

        // Рисуем шестиугольник
        hexagon.path = hexagonPathWithCenter(center: CGPoint(x: 200, y: 400), radius: 50).cgPath
        hexagon.fillColor = UIColor.purple.cgColor
        
        let frame = CGRect(x: 0, y: 0, width: 500, height: 500)
        
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [UIColor.blue.cgColor, UIColor.yellow.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.mask = triangle

        shadow.path = hexagon.path
        shadow.fillColor = hexagon.fillColor
        shadow.shadowColor = UIColor.black.cgColor
        shadow.shadowOffset = CGSize(width: 3.0, height: 10)
        shadow.shadowOpacity = 1.0
        shadow.shadowRadius = 6
        shadow.rasterizationScale = UIScreen.main.scale

        self.view.layer.addSublayer(gradient)
        self.view.layer.addSublayer(shadow)
        self.view.layer.addSublayer(triangle)
        self.view.layer.addSublayer(hexagon)

        // Добавление распознавателей жестов
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipe(_:)))
        self.view.addGestureRecognizer(swipeGesture)

        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotate(_:)))
        self.view.addGestureRecognizer(rotateGesture)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        self.view.addGestureRecognizer(tapGesture)

        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(lPress(_:)))
        self.view.addGestureRecognizer(longPressGesture)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(drop(_:)))
        self.view.addGestureRecognizer(panGesture)
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

    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
        changeColors(triangleColor: UIColor.red.cgColor, hexagonColor: UIColor.red.cgColor, shadowColor: UIColor.red.cgColor)
    }

    @IBAction func rotate(_ sender: UIRotationGestureRecognizer) {
        changeColors(triangleColor: UIColor.yellow.cgColor, hexagonColor: UIColor.yellow.cgColor, shadowColor: UIColor.yellow.cgColor)
    }

    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        changeColors(triangleColor: UIColor.green.cgColor, hexagonColor: UIColor.green.cgColor, shadowColor: UIColor.green.cgColor)
    }

    @IBAction func lPress(_ sender: UILongPressGestureRecognizer) {
        changeColors(triangleColor: UIColor.magenta.cgColor, hexagonColor: UIColor.magenta.cgColor, shadowColor: UIColor.magenta.cgColor)
    }

    @IBAction func drop(_ sender: UIPanGestureRecognizer) {
        changeColors(triangleColor: UIColor.brown.cgColor, hexagonColor: UIColor.brown.cgColor, shadowColor: UIColor.brown.cgColor)
    }

    func changeColors(triangleColor: CGColor, hexagonColor: CGColor, shadowColor: CGColor) {
        triangle.fillColor = triangleColor
        hexagon.fillColor = hexagonColor
        shadow.fillColor = hexagonColor
        shadow.shadowColor = shadowColor
    }
}
