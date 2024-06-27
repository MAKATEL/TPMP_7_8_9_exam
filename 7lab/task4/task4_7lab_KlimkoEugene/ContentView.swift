//
//  ViewController.swift
//  7lab_1task_KlimkoEugene
//
//  Created by MacOSExi on 14.05.24.
//  Copyright © 2024 MacOSExi. All rights reserved.
//


import SwiftUI

struct ContentView: View {
    let rTarget = Double.random(in: 0..<1)
    let gTarget = Double.random(in: 0..<1)
    let bTarget = Double.random(in: 0..<1)
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    
    func computeScore() -> Int {
      let rDiff = rGuess - rTarget
      let gDiff = gGuess - gTarget
      let bDiff = bGuess - bTarget
      let diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
      return Int((1.0 - diff) * 100.0 + 0.5)
    }
    @State var showAlert = false
    var body: some View {
        VStack {
            HStack(spacing: 70.0) {
                Text("Target Color Block")
                  Text("Guess Color Block")
            }
            
            HStack {
              // Target color block
              VStack {
                Rectangle()
                    .foregroundColor(Color(red: rTarget, green: gTarget, blue: bTarget, opacity: 1.0))
                    .frame(height: 200.0)
                Text("Match this color")
              }
              // Guess color block
              VStack {
                Rectangle()
                    .frame(height: 200.0)
                    .foregroundColor(Color(red: rGuess, green: gGuess, blue: bGuess, opacity: 1.0))
                HStack {
                    Text("R: \(Int(rGuess * 255.0))")
                    Text("G: \(Int(gGuess * 255.0))")
                    Text("B: \(Int(bGuess * 255.0))")
                }
              }
            }
            .padding()
            Button(action: {
              self.showAlert = true
            }) {
                Text("Hit Me!")
                    .font(.title)
                    .fontWeight(.heavy)
            }
            .alert(isPresented: $showAlert) {
              Alert(title: Text("Your Score"), message: Text("\(computeScore())"))
            }
            
            VStack {
                ColorSlider(value: $rGuess, textColor: .red)
                .padding()
                ColorSlider(value: $gGuess, textColor: .green)
                .padding()
                ColorSlider(value: $bGuess, textColor: .blue)
                .padding()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    var textColor: Color
    var body: some View {
        HStack {
            Text("0")
                .foregroundColor(textColor)
            Slider(value: $value)
            Text("255")
                .foregroundColor(textColor)
        }
        .padding()
    }
}
