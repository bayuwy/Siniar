//
//  MainViewController.swift
//  Siniar
//
//  Created by Bayu Yasaputro on 06/08/22.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        tabBar.tintColor = UIColor.Siniar.brand1
        tabBar.unselectedItemTintColor = UIColor.Siniar.neutral2
        
        let home = UINavigationController(rootViewController: HomeViewController())
        home.title = "Home"
        home.tabBarItem.image = UIImage(named: "tab_home")
        home.tabBarItem.selectedImage = UIImage(named: "tab_home")
        
        let search = UINavigationController(rootViewController: SearchViewController())
        search.title = "Search"
        search.tabBarItem.image = UIImage(named: "tab_search")
        search.tabBarItem.selectedImage = UIImage(named: "tab_search")
        
        let account = UINavigationController(rootViewController: AccountViewController())
        account.title = "Account"
        account.tabBarItem.image = UIImage(named: "tab_account")
        account.tabBarItem.selectedImage = UIImage(named: "tab_account")
        
        viewControllers = [home, search, account]
    }
}

extension UIViewController {
    func showMainViewController() {
        let viewController = MainViewController()
        let  window = UIApplication.shared.windows.first { $0.isKeyWindow }
        window?.rootViewController = viewController
    }
}
