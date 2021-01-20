//
//  MainTabBarController.swift
//  ChuckNorrisJokes
//
//  Created by Sergey on 1/19/21.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }

    private func createVC(controller: UIViewController, name: String, imageName: String) -> UINavigationController {
        let vc = controller
        
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = name
        nav.tabBarItem.image = UIImage(named: imageName)
        
        UITabBar.appearance().backgroundColor = .lightGray
        tabBar.backgroundImage = UIImage()
        tabBar.unselectedItemTintColor = .black
        tabBar.tintColor = .white
        return nav
    }
    
    private func setupControllers() {
        let firstController = createVC(controller: JokesController(), name: "Jokes", imageName: "joke")
        let secondController = createVC(controller: WebViewScreenController(), name: "API", imageName: "brackets")

        viewControllers = [firstController, secondController]
    }

}
