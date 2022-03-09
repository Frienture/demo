//
//  TabBarViewController.swift
//  demo
//
//  Created by macbookpro on 19/9/2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupController()
    }
    private func setupController () {
        let home = GroupsViewController()
        let profile = ProfielViewController()
        let discussion = DiscussionViewController()
        home.title = "Home"
        
//        home.navigationItem.titleView = .
        
        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: profile)
        let nav3 = UINavigationController(rootViewController: discussion)
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Discuss", image: UIImage(systemName: "ellipses.bubble"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 3)
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }

}

