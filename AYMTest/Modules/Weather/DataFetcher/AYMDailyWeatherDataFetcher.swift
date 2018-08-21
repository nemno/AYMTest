//
//  AYMDailyWeatherDataFetcher.swift
//  AYMTest
//
//  Created by Norbert Nemes on 2018. 08. 20..
//  Copyright © 2018. Norbert Nemes. All rights reserved.
//

import UIKit
import Alamofire

class AYMDailyWeatherDataFetcher: NSObject {
    let locationManager: AYMLocationManager
    
    public typealias AsyncCompletion = (_ data:[AYMDailyWeather]?, _ error:Error?) -> Void
    
    init(locationManager: AYMLocationManager) {
        self.locationManager = locationManager
    }
    
    func fetchWeatherForecast(completion: @escaping AsyncCompletion) {
        let openWeatherMapAPIURL = "https://api.openweathermap.org/data/2.5/forecast"
        
        locationManager.getCurrentLocation { (location, locationError) in
            if let currentLocation = location {
                let params: [String : Any] = ["lat": currentLocation.coordinate.latitude, "lon": currentLocation.coordinate.longitude, "appid": openWeatherMapAPIKey, "units": "metric"]
                
                let request = Alamofire.request(openWeatherMapAPIURL, method: .get, parameters: params)
                request.responseJSON { [weak self] (response) in
                    if let result = response.result.value {
                        completion(self?.parseResponse(response: result), nil)
                    } else {
                        completion(nil, response.error)
                    }
                }
            } else if let locationError = locationError {
                completion(nil, locationError)
            }
        }
    }
    
    private func parseResponse(response: Any) -> [AYMDailyWeather]? {
        var responseArray: [[String: Any]]
        var dataObjectArray = [AYMDailyWeather]()
        
        if let response = response as? [String: Any], let results = response["list"] as? [[String: Any]] {
            responseArray = results
            
            for dictionary in responseArray {
                let dailyWeather = AYMDailyWeather(dataDictionary: dictionary)
                
                if let cityDict = response["city"] as? [String: Any] {
                    if let cityName = cityDict["name"] as? String {
                        dailyWeather.city = cityName
                    }
                }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH"
                if (dateFormatter.string(from: dailyWeather.date) == "12") {
                    dataObjectArray.append(dailyWeather)
                }
            }
            
            return dataObjectArray
        } else {
            assertionFailure("Unexpected response!")
            return nil
        }
    }
}
