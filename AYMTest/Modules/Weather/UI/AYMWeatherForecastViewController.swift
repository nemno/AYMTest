//
//  AYMWeatherForecastViewController.swift
//  AYMTest
//
//  Created by Norbert Nemes on 2018. 08. 19..
//  Copyright © 2018. Norbert Nemes. All rights reserved.
//

import UIKit

class AYMWeatherForecastViewController: UIViewController {

    var navigationManager: AYMNavigationManager?
    let locationManager: AYMLocationManager
    let dataFetcher: AYMDailyWeatherDataFetcher!
    
    init(locationManager: AYMLocationManager) {
        self.locationManager = locationManager
        self.dataFetcher = AYMDailyWeatherDataFetcher(locationManager: locationManager)
        super.init(nibName: nil, bundle: nil)
        self.title = "Weather forecast"
        self.tabBarItem.image = UIImage(named: "weatherTabBarIcon")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationManager?.showLoadingOn(viewController: self)
        fetchAndShowData()
    }
    
    private func fetchAndShowData() {
        dataFetcher.fetchWeatherForecast { [weak self] (data, error) in
            guard let viewController = self else { return }
            
            viewController.navigationManager?.hideLoadingView()
            if error != nil {
                viewController.navigationManager?.showErrorAlert(title: "Error", message: "Could not get restaurants data!", presentingViewController: viewController)
            } else {
                
            }
        }
    }
}
