//
//  AYMWeatherForecastViewController.swift
//  AYMTest
//
//  Created by Norbert Nemes on 2018. 08. 19..
//  Copyright © 2018. Norbert Nemes. All rights reserved.
//

import UIKit
import SDWebImage

class AYMWeatherForecastViewController: UIViewController, NAvigationAwareViewController {

    var navigationManager: AYMNavigationManager?
    let locationManager: AYMLocationManager
    let dataFetcher: AYMDailyWeatherDataFetcher!
    
    let cityLabel: UILabel
    let weatherIconImageView: UIImageView
    
    var forecastScrollView: UIScrollView?
    
    init(locationManager: AYMLocationManager) {
        self.locationManager = locationManager
        self.dataFetcher = AYMDailyWeatherDataFetcher(locationManager: locationManager)
        cityLabel = UILabel()
        weatherIconImageView = UIImageView()
        super.init(nibName: nil, bundle: nil)
        self.title = "Weather forecast"
        self.tabBarItem.image = UIImage(named: "weatherTabBarIcon")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        cityLabel.frame = CGRect(x: 20.0, y: 40.0, width: self.view.frame.width - 40.0, height: 40.0)
        cityLabel.textAlignment = .left
        cityLabel.textColor = .black
        cityLabel.font = .boldSystemFont(ofSize: 24.0)
        self.view.addSubview(cityLabel)
        
        weatherIconImageView.frame = CGRect(x: (self.view.frame.width - 100.0) / 2.0, y: cityLabel.frame.maxY + 40.0, width: 100.0, height: 100.0)
        self.view.addSubview(weatherIconImageView)
        
        forecastScrollView = UIScrollView(frame: CGRect(x: 0.0, y: self.view.frame.height - 160.0, width: self.view.frame.width, height: 160.0))
        
        if let scrollView = forecastScrollView {
            self.view.addSubview(scrollView)
        }
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
            
            if error != nil {
                viewController.navigationManager?.showErrorAlert(title: "Error", message: "Could not get restaurants data!", presentingViewController: viewController)
            } else {
                guard let data = data, let forecastScrollView = self?.forecastScrollView else { return }
                
                self?.cityLabel.text = data.first?.city
                self?.weatherIconImageView.sd_setImage(with: data.first?.iconImageURL)
                
                var index = 0.0
                for forecastDAO in data {
                    let forecastView = AYMSmallWeatherForecastView(frame: CGRect(x: index * 60.0, y: 0.0, width: 60.0, height: Double(forecastScrollView.frame.height)))
                    forecastScrollView.addSubview(forecastView)
                    forecastView.weather = forecastDAO
                    index += 1.0
                }
                
                forecastScrollView.contentSize = CGSize(width: index * 60.0, height: Double(forecastScrollView.frame.height))
            }
            viewController.navigationManager?.hideLoadingView()
        }
    }
}
