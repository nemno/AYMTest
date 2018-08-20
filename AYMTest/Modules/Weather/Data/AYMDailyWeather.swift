//
//  AYMDailyWeather.swift
//  AYMTest
//
//  Created by Norbert Nemes on 2018. 08. 20..
//  Copyright © 2018. Norbert Nemes. All rights reserved.
//

import UIKit

class AYMDailyWeather: NSObject {
    let weatherDescription: String
    let temperature: Double
    let wind: Double
    let humidity: Double
    let date: Date

    init(dataDictionary: [String: Any]) {
        if let weatherArray = dataDictionary["weather"] as? [[String: Any]], let mainDict = dataDictionary["main"] as? [String: Any], let windDict = dataDictionary["wind"] as? [String: Any] {
            if let weatherDescription = weatherArray[0]["description"] as? String {
                self.weatherDescription = weatherDescription
            } else {
                self.weatherDescription = ""
            }
            
            if let temperature = mainDict["temp"] as? Double {
                self.temperature = temperature
            } else {
                self.temperature = 0.0
            }
            
            if let wind = windDict["speed"] as? Double {
                self.wind = wind
            } else {
                self.wind = 0.0
            }
            
            if let humidity = mainDict["humidity"] as? Double {
                self.humidity = humidity
            } else {
                self.humidity = 0.0
            }
            
            if let dateString = dataDictionary["dt_text"] as? String {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                if let date = dateFormatter.date(from: dateString) {
                    self.date = date
                } else {
                    self.date = Date(timeIntervalSince1970: 0)
                }
            } else {
                self.date = Date(timeIntervalSince1970: 0)
            }
        } else {
            assertionFailure("Unexpected data from API")
            self.weatherDescription = ""
            self.temperature = 0.0
            self.wind = 0.0
            self.humidity = 0.0
            self.date = Date(timeIntervalSince1970: 0)
        }
        
        super.init()
    }
}
