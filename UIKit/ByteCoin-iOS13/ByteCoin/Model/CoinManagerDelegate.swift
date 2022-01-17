//
//  CoinManagerDelegate.swift
//  ByteCoin
//
//  Created by Le Hoang Anh on 25/09/2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didFailWithError(error: Error)
    func didUpdatePrice(price: String, currency: String)
}
