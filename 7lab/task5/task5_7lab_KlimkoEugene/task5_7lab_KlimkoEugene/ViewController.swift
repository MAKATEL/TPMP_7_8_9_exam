//
//  ViewController.swift
//  task5_7lab_KlimkoEugene
//
//  Created by MacOSExi on 15.05.24.
//  Copyright © 2024 MacOSExi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var fiveSystem: UIButton!
    @IBOutlet weak var twelveSystem: UIButton!
    @IBOutlet weak var twentyFiveSystem: UIButton!
    @IBOutlet weak var mathAnalisys: UITextField!
    @IBOutlet weak var geometry: UITextField!
    @IBOutlet weak var programming: UITextField!
    @IBOutlet weak var coutLabel: UILabel!
    
     override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        @IBAction func convertToFiveScale(_ sender: UIButton) {
            updateGrades(using: convertToFivePointScale)
        }
        
        @IBAction func convertToTwelveScale(_ sender: UIButton) {
            updateGrades(using: convertToTwelvePointScale)
        }
        
        @IBAction func convertToTwentyFiveScale(_ sender: UIButton) {
            updateGrades(using: convertToTwentyFivePointScale)
        }
        
        private func updateGrades(using conversionFunction: (Double) -> Double) {
            let grades = [mathAnalisys, geometry, programming].compactMap { Double($0?.text ?? "") }
            guard !grades.isEmpty else {
                coutLabel.text = "Please enter valid grades."
                return
            }
            
            let average = grades.reduce(0, +) / Double(grades.count)
            let convertedGrade = conversionFunction(average)
            coutLabel.text = String(format: "%.2f", convertedGrade)
        }
        
        private func convertToFivePointScale(average: Double) -> Double {
            // Пример преобразования, здесь могут быть ваша логика или формула
            return average * 5 / 10
        }
        
        private func convertToTwelvePointScale(average: Double) -> Double {
            // Пример преобразования, здесь могут быть ваша логика или формула
            return average * 12 / 10
        }
        
        private func convertToTwentyFivePointScale(average: Double) -> Double {
            // Пример преобразования, здесь могут быть ваша логика или формула
            return average * 25 / 10
        }
    }
