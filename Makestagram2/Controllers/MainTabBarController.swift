//
//  MainTabBarController.swift
//  Makestagram2
//
//  Created by Mark Wang on 6/30/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    let photoHelper = MGPhotoHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoHelper.completionHandler = { image in
            //print("handle image")
            PostService.create(for: image)
        }
        
        delegate = self
        tabBar.unselectedItemTintColor = .black
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.tag == 1 {
            // present photo taking action sheet
            
            photoHelper.presentActionSheet(from: self)
            
            return false
        }
        
        return true
    }
}
