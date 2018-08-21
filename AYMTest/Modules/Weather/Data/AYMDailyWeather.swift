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
    let minTemperature: Double
    let maxTemperature: Double
    let wind: Double
    let humidity: Double
    let date: Date
    var city: String?
    let iconImageURL: URL?

    init(dataDictionary: [String: Any]) {
        if let weatherArray = dataDictionary["weather"] as? [[String: Any]], let mainDict = dataDictionary["main"] as? [String: Any], let windDict = dataDictionary["wind"] as? [String: Any] {
            if let weatherDescription = weatherArray[0]["description"] as? String {
                self.weatherDescription = weatherDescription
            } else {
                self.weatherDescription = ""
            }
            
            if let iconURLString = weatherArray[0]["icon"] as? String {
                self.iconImageURL = URL(string: "https://openweathermap.org/img/w/" + iconURLString + ".png")
            } else {
                self.iconImageURL = nil
            }
            
            if let minTemperature = mainDict["temp_min"] as? Double {
                self.minTemperature = minTemperature
            } else {
                self.minTemperature = 0.0
            }
            
            if let maxTemperature = mainDict["temp_max"] as? Double {
                self.maxTemperature = maxTemperature
            } else {
                self.maxTemperature = 0.0
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
            
            if let dateString = dataDictionary["dt_txt"] as? String {
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
            self.minTemperature = 0.0
            self.maxTemperature = 0.0
            self.wind = 0.0
            self.humidity = 0.0
            self.date = Date(timeIntervalSince1970: 0)
            self.city = ""
            self.iconImageURL = nil
        }
        
        super.init()
    }
}
