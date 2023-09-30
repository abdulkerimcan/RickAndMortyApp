//
//  ViewController.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 25.09.2023.
//

import UIKit

final class TabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setTabs()
    }
    
    private func setTabs() {
        let vc1 = CharacterVC()
        let vc2 = LocationVC()
        let vc3 = EpisodeVC()
        let vc4 = SettingsVC()
        
        vc1.navigationItem.largeTitleDisplayMode = .automatic
        vc2.navigationItem.largeTitleDisplayMode = .automatic
        vc3.navigationItem.largeTitleDisplayMode = .automatic
        vc4.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        
        nav1.tabBarItem = UITabBarItem(title: "Character", image: UIImage(systemName: "person"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "globe.europe.africa.fill"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv" ), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)
        
        let navs = [nav1,nav2,nav3,nav4]
        
        for nav in navs {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(navs, animated: true)
        
    }
}

