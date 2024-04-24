//
//  ViewController.swift
//  Netflix Clone
//
//  Created by Moamen on 31/03/2024.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let vo1 = UINavigationController(rootViewController: HomeViewController())
        let vo2 = UINavigationController(rootViewController: UpComingViewController())
        let vo3 = UINavigationController(rootViewController: SearchsViewController())
        let vo4 = UINavigationController(rootViewController: DownloadsViewController())
        
        vo1.title = "Home"
        vo2.title = "UpComing"
        vo3.title = "Top Search"
        vo4.title = "Downloads"
        
        vo1.tabBarItem.image = UIImage(systemName: "house")
        vo2.tabBarItem.image = UIImage(systemName: "play.circle")
        vo3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vo4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")

        
        tabBar.tintColor = .label
        setViewControllers([vo1,vo2,vo3,vo4], animated: true)
}


}

