//
//  ViewController.swift
//  8lab_example4_KlimkoEugene
//
//  Created by MacOSExi on 16.05.24.
//  Copyright © 2024 MacOSExi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var output: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.textAlignment = NSTextAlignment.center
        output.numberOfLines = 2
        output.text = "Используйте жесты в этой области"
        output.backgroundColor = UIColor.yellow

        // Добавление распознавателя жестов pinch
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinch(_:)))
        output.addGestureRecognizer(pinchGesture)
        
        // Добавление распознавателя жестов long tap
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(long(_:)))
        output.addGestureRecognizer(longPressGesture)
        
        // Добавление распознавателя жестов tap
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        output.addGestureRecognizer(tapGesture)
        
        // Добавление распознавателя жестов rotation
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotation(_:)))
        output.addGestureRecognizer(rotationGesture)
        
        // Добавление распознавателя жестов swipe
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipe(_:)))
        swipeGesture.direction = [.left, .right] // Настройка направления свайпа
        output.addGestureRecognizer(swipeGesture)
        
        // Включение взаимодействия с пользователем для label
        output.isUserInteractionEnabled = true
    }
    
    @objc func pinch(_ sender: UIPinchGestureRecognizer) {
         output.text = "Жест: pinch\n Цвет фона: red"
         output.backgroundColor = UIColor.red
    }
    
    @objc func long(_ sender: UILongPressGestureRecognizer) {
         output.text = "Жест: long tap\n Цвет фона: blue"
         output.backgroundColor = UIColor.blue
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        output.text = "Жест: касание\n Цвет фона: зеленый"
        output.backgroundColor = UIColor.green
    }
    
    @objc func rotation(_ sender: UIRotationGestureRecognizer) {
        output.text = "Жест: rotation\n Цвет фона: white"
        output.backgroundColor = UIColor.white
    }
    
    @objc func swipe(_ sender: UISwipeGestureRecognizer) {
         output.text = "Жест: swipe\n Цвет фона: orange"
         output.backgroundColor = UIColor.orange
    }
}
