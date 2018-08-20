//
//  AYMRestaurantsViewController.swift
//  AYMTest
//
//  Created by Norbert Nemes on 2018. 08. 17..
//  Copyright © 2018. Norbert Nemes. All rights reserved.
//

import UIKit

class AYMRestaurantsViewController: UIViewController, NAvigationAwareViewController {

    var tableView: UITableView!
    var tableDelegate: AYMRestaurantsTableDelegate!
    
    let dataFetcher: AYMRestaurantsDataFetcher!
    var navigationManager: AYMNavigationManager?
    let locationManager: AYMLocationManager
    
    init(locationManager: AYMLocationManager) {
        self.dataFetcher = AYMRestaurantsDataFetcher(locationManager: locationManager)
        self.locationManager = locationManager
        super.init(nibName: nil, bundle: nil)
        self.title = "Restaurants"
        self.tabBarItem.image = UIImage(named: "restaurantTabBarIcon")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: self.view.bounds)
        tableDelegate = AYMRestaurantsTableDelegate()
        tableView.delegate = tableDelegate
        tableView.dataSource = tableDelegate
        tableView.register(AYMRestaurantTableViewCell.self, forCellReuseIdentifier: "restaurantTableViewCell")
        
        self.view.addSubview(tableView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationManager?.showLoadingOn(viewController: self)
        fetchAndShowData()
    }
    
    private func fetchAndShowData() {
        dataFetcher.fetchRestaurants { [weak self] (data, error) in
            guard let viewController = self else { return }

            viewController.navigationManager?.hideLoadingView()
            if error != nil {
                viewController.navigationManager?.showErrorAlert(title: "Error", message: "Could not get restaurants data!", presentingViewController: viewController)
            } else {
                self?.tableDelegate.restaurants = data
                self?.tableView.reloadData()
            }
        }
    }
}
