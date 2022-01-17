//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Le Hoang Anh on 17/09/2021.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    
    var bmi: BMI?
    
    func getBMIValue() -> String {
        return String(format: "%.1f", bmi?.value ?? 0.0)
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? "No advice"
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? .clear
    }
    
    mutating func calculateBMI(height: Float, weight: Float) {
        let bmiValue = weight / (height * height)
        
        if bmiValue < 18.5 {
            bmi = .init(value: bmiValue, advice: "Eat more pies!", color: .blue)
        } else if bmiValue <= 24.9 {
            bmi = .init(value: bmiValue, advice: "Fit as a fiddle!", color: .green)
        } else {
            bmi = .init(value: bmiValue, advice: "Eat less pies!", color: .red)
        }
    }
    
}
