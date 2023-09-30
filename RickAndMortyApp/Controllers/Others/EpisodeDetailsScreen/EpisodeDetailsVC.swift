//
//  EpisodeDetailsVC.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 30.09.2023.
//

import UIKit

final class EpisodeDetailsVC: UIViewController {
    let episode: Episode
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = episode.name
    }
    init(episode: Episode) {
        self.episode = episode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
