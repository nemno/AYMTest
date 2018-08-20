//
//  AYMRestaurantsDataFetcher.swift
//  AYMTest
//
//  Created by Norbert Nemes on 2018. 08. 18..
//  Copyright © 2018. Norbert Nemes. All rights reserved.
//

import UIKit
import Alamofire

class AYMRestaurantsDataFetcher: NSObject {
    var cachedRestaurants: [AYMRestaurant]?
    let locationManager: AYMLocationManager
    
    public typealias AsyncCompletion = (_ data:[AYMRestaurant]?, _ error:Error?) -> Void
    
    init(locationManager: AYMLocationManager) {
        self.locationManager = locationManager
    }
    
    func fetchRestaurants(completion: @escaping AsyncCompletion) {
        let googlePlacesAPIURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
        
        locationManager.getCurrentLocation { (location, locationError) in
            if let currentLocation = location {
                let locationString = String(currentLocation.coordinate.latitude) + "," + String(currentLocation.coordinate.longitude)
                let params: [String : Any] = ["location": locationString, "radius": "3000", "type": "restaurant", "key": googleAPIKey]

                let request = Alamofire.request(googlePlacesAPIURL, method: .get, parameters: params)
                request.responseJSON { [weak self] (response) in
                    if let result = response.result.value {
                        let restaurants = self?.parseResponse(response: result)
                        self?.cachedRestaurants = restaurants
                        completion(restaurants, nil)
                    } else {
                        completion(nil, response.error)
                    }
                }
            } else if let locationError = locationError {
                completion(nil, locationError)
            }
        }
    }
    
    private func parseResponse(response: Any) -> [AYMRestaurant]? {
        var responseArray: [[String: Any]]
        var dataObjectArray = [AYMRestaurant]()
        
        if let response = response as? [String: Any], let results = response["results"] as? [[String: Any]] {
            responseArray = results
        } else {
            assertionFailure("Unexpected response!")
            return nil
        }
        
        for dictionary in responseArray {
            dataObjectArray.append(AYMRestaurant(dataDictionary: dictionary))
        }
        
        return dataObjectArray
    }
}
