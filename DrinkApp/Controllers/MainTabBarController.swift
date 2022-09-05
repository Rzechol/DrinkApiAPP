//
//  MainTabBarController.swift
//  DrinkApp
//
//  Created by Bartosz Rzechółka on 24/08/2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: SearchViewController())
      
        
        vc1.title = "Home"
        vc2.title = "Search"
                
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
       
      
        
        tabBar.tintColor = .white
        tabBar.barTintColor = .black
        
        for vc in [vc1, vc2] {
            vc.overrideUserInterfaceStyle = .dark
        }
        
        setViewControllers([vc1, vc2 ], animated: true)
    }
}
