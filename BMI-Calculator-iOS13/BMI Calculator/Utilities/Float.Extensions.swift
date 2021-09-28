//
//  Float.Extensions.swift
//  BMI Calculator
//
//  Created by Le Hoang Anh on 17/09/2021.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation

extension Float {
    mutating func round(toPlaces places: Int) {
        self = Float(String(format: "%.\(places)f", self))!
    }
    
    func rounded(toPlaces places: Int) -> Float {
        return Float(String(format: "%.\(places)f", self))!
    }
}
