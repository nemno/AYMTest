//
//  AYMAppAssembly.swift
//  AYMTest
//
//  Created by Norbert Nemes on 2018. 08. 18..
//  Copyright © 2018. Norbert Nemes. All rights reserved.
//

import UIKit

class AYMAppAssembly: NSObject {
    let navigatonManager: AYMNavigationManager!
    let locationManager: AYMLocationManager!
    
    override init() {
        self.locationManager = AYMLocationManager()
        self.navigatonManager = AYMAppAssembly.generateNavigationManager(locationManager: self.locationManager)
        super.init()
    }

    private class func generateNavigationManager(locationManager: AYMLocationManager) -> AYMNavigationManager {
        let tabBarController = UITabBarController(nibName: nil, bundle: nil)
        let weatherViewController = AYMWeatherForecastViewController(locationManager: locationManager)
        let restaurantsViewController = AYMRestaurantsViewController(locationManager: locationManager)
        tabBarController.viewControllers = [weatherViewController, restaurantsViewController]
        
        return AYMNavigationManager(rootViewController: tabBarController, viewControllers: [weatherViewController, restaurantsViewController])
    }
}
