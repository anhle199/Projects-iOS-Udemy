//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "EF842B65-60E6-423A-AE85-EC724CA87871"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    self.delegate?.didFailWithError(error: error)
                    return
                }
                
                if let safeData = data, let price = self.parseJSON(safeData) {
                    let priceString = String(format: "%.2f", price)
                    self.delegate?.didUpdatePrice(price: priceString, currency: currency)
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> Double? {
        do {
            let decoder = JSONDecoder()
            let dataDecoded = try decoder.decode(CoinData.self, from: data)
            
            return dataDecoded.rate
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
