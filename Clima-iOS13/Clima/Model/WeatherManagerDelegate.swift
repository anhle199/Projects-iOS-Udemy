//
//  WeatherManagerDelegate.swift
//  Clima
//
//  Created by Le Hoang Anh on 23/09/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func weatherManagerDidUpdate(_ weatherManager: WeatherManager, weather: WeatherModel)
    func weatherManagerDidFail(error: Error)
}
