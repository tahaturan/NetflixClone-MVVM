//
//  SceneDelegate.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 12.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = MainTabbarController()
        window?.makeKeyAndVisible()
        
        if let urlContext = connectionOptions.urlContexts.first {
            handleDeepLink(url: urlContext.url)
        }
    }
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let urlContext = URLContexts.first {
            handleDeepLink(url: urlContext.url)
        }
    }
    
    private func handleDeepLink(url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
        let tabbarController = window?.rootViewController as? UITabBarController,
        let navigationController = tabbarController.viewControllers?.first(where: {viewController in
            viewController is UINavigationController
        }) as? UINavigationController,
        let movieID = components.queryItems?.first(where: {$0.name == "id"})?.value
        else { return }
        guard let movieIDINT = Int(movieID) else { return }
        
        switch components.path {
        case "/movie":
            goDetailFromURL(movieID: movieIDINT, navigationController: navigationController)
        default:
            goDetailFromURL(movieID: movieIDINT, navigationController: navigationController)
        }
    }
    private func goDetailFromURL(movieID: Int, navigationController: UINavigationController) {
        let detailVC = DetailViewBuilder.makeDetailViewController(movieID: movieID)
        navigationController.pushViewController(detailVC, animated: true)
    }
}

