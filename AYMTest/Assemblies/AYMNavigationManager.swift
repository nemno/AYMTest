//
//  AYMNavigationManager.swift
//  AYMTest
//
//  Created by Norbert Nemes on 2018. 08. 17..
//  Copyright © 2018. Norbert Nemes. All rights reserved.
//

import UIKit

protocol NAvigationAwareViewController {
    var navigationManager: AYMNavigationManager? { get set }
}

class AYMNavigationManager: NSObject {
    let rootViewController: UIViewController!
    var viewControllers: [NAvigationAwareViewController]
    
    var loadingView: UIView?
    
    init(rootViewController: UIViewController, viewControllers: [NAvigationAwareViewController]) {
        self.rootViewController = rootViewController
        self.viewControllers = viewControllers
        
        super.init()
        
        for i in (0...viewControllers.count - 1) {
            var viewController = viewControllers[i]
            viewController.navigationManager = self
        }
    }
    
    func showErrorAlert(title: String, message: String, presentingViewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
        }))
        presentingViewController.present(alertController, animated: true)
    }
    
    func showLoadingOn(viewController: UIViewController) {
        loadingView = UIView(frame: viewController.view.frame)
        loadingView?.backgroundColor = UIColor(white: 0.0, alpha: 0.3)
        viewController.view.addSubview(loadingView!)
    }
    
    func hideLoadingView() {
        loadingView?.removeFromSuperview()
    }
}
