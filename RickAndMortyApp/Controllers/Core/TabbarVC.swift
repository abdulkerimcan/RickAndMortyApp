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
        
        let nav1 = UINavigationController(rootViewController: createCharacterVC())
        let nav2 = UINavigationController(rootViewController: createLocationVC())
        let nav3 = UINavigationController(rootViewController: createEpisodeVC())
        let nav4 = UINavigationController(rootViewController: createSettingVC())
        
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

private extension UIViewController {
    func createCharacterVC() -> CharacterVC {
        CharacterVC(viewModel: CharacterViewModel(service: Service()))
    }
    func createLocationVC() -> LocationVC {
        LocationVC(viewModel: LocationViewModel(service: Service()))
    }
    func createEpisodeVC() -> EpisodeVC {
        EpisodeVC(viewModel: EpisodeViewModel(service: Service()))
    }
    func createSettingVC() -> SettingsVC {
        SettingsVC()
    }
}

