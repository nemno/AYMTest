//
//  AYMRestaurant.swift
//  AYMTest
//
//  Created by Norbert Nemes on 2018. 08. 18..
//  Copyright © 2018. Norbert Nemes. All rights reserved.
//

import UIKit

class AYMRestaurant: NSObject {
    let name: String
    let address: String
    let imageURL: URL?
    let rating: Double
    
    init(dataDictionary: [String: Any]) {
        if let name = dataDictionary["name"] as? String {
            self.name = name
        } else {
            self.name = ""
        }

        if let address = dataDictionary["vicinity"] as? String {
            self.address = address
        } else {
            self.address = ""
        }
        
        if let iconURLString = dataDictionary["icon"] as? String {
            self.imageURL = URL(string: iconURLString)
        } else {
            self.imageURL = nil
        }
        
        if let rating = dataDictionary["rating"] as? Double {
            self.rating = rating
        } else {
            self.rating = 0.0
        }
        
        super.init()
    }
}
