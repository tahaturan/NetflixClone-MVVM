//
//  MainTabbarController.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 12.02.2024.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        createTabbar()
        
    }
    
    private func createTabbar() {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let discoverVC = UINavigationController(rootViewController: DiscoverViewController())
        let upComingVC = UINavigationController(rootViewController: UpComingViewController())
        let downloadVC = UINavigationController(rootViewController: DownloadViewController())
        
        homeVC.title = "Home"
        discoverVC.title = "Discover"
        upComingVC.title = "Coming Soon"
        downloadVC.title = "Download"
        
        homeVC.tabBarItem.image = AppIcon.home.image()
        discoverVC.tabBarItem.image = AppIcon.discover.image()
        upComingVC.tabBarItem.image = AppIcon.upComing.image()
        downloadVC.tabBarItem.image = AppIcon.download.image()
        
        
        tabBar.backgroundColor = .tabbarBackround
        tabBar.tintColor = .tabbarSelected
        tabBar.barTintColor = .tabbarUnSelected
        
        
        let viewControllers: [UIViewController] = [homeVC, discoverVC, upComingVC, downloadVC]
        
        setViewControllers(viewControllers, animated: true)
    }
}
