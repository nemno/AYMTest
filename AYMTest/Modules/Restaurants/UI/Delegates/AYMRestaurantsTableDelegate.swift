//
//  AYMRestaurantsTableDelegate.swift
//  AYMTest
//
//  Created by Norbert Nemes on 2018. 08. 17..
//  Copyright © 2018. Norbert Nemes. All rights reserved.
//

import UIKit

class AYMRestaurantsTableDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var restaurants: [AYMRestaurant]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantTableViewCell", for: indexPath)
        
        if let restaurantCell = cell as? AYMRestaurantTableViewCell, let restaurant = restaurants?[indexPath.row] {
            restaurantCell.restaurant = restaurant
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}
