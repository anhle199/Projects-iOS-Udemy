//
//  WeatherManager.swift
//  Clima
//
//  Created by Le Hoang Anh on 22/09/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=c30a93f4745c8e3513c166c7a051e7e9&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
    
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                self.delegate?.weatherManagerDidFail(error: error)
                return
            }
            
            if let safeData = data,
               let weather = self.parseJSON(safeData) {
                
                self.delegate?.weatherManagerDidUpdate(self, weather: weather)
            }
        }
        
        task.resume()
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()

        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name

            return WeatherModel(conditionId: id, cityName: name, temperature: temp)
        } catch {
            delegate?.weatherManagerDidFail(error: error)
            return nil
        }
    }
 
}
