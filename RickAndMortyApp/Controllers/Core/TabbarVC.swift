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
        
        let navs = [createCharacterVC(),createLocationVC(),createEpisodeVC(),createSettingVC()]
        
        setViewControllers(navs, animated: true)
    }
}

private extension UIViewController {
    func createCharacterVC() -> UINavigationController {
        let characterVC = CharacterVC(viewModel: CharacterViewModel(service: Service()))
        let nav = UINavigationController(rootViewController: characterVC)
        nav.tabBarItem = UITabBarItem(title: "Character", image: UIImage(systemName: "person"), tag: 1)
        nav.navigationBar.prefersLargeTitles = true
        return nav
    }
    func createLocationVC() -> UINavigationController {
        let locationVC = LocationVC(viewModel: LocationViewModel(service: Service()))
        let nav = UINavigationController(rootViewController: locationVC)
        nav.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "globe.europe.africa.fill"), tag: 2)
        nav.navigationBar.prefersLargeTitles = true
        return nav
    }
    func createEpisodeVC() -> UINavigationController {
        let episodeVC = EpisodeVC(viewModel: EpisodeViewModel(service: Service()))
        let nav = UINavigationController(rootViewController: episodeVC)
        nav.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv" ), tag: 3)
        nav.navigationBar.prefersLargeTitles = true
        return nav
    }
    func createSettingVC() -> UINavigationController {
        let settingsVC = SettingsVC()
        let nav = UINavigationController(rootViewController: settingsVC)
        nav.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)
        nav.navigationBar.prefersLargeTitles = true
        return nav
    }
}

