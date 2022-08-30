//
//  MainViewController.swift
//  Siniar
//
//  Created by Bayu Yasaputro on 06/08/22.
//

import UIKit
import Kingfisher
import MediaPlayer

class MainViewController: UITabBarController {
    weak var playerView: UIView!
    weak var episodeImageView: UIImageView!
    weak var episodeTitleLabel: UILabel!
    weak var previousButton: UIButton!
    weak var playButton: UIButton!
    weak var nextButton: UIButton!
    weak var progressView: UIView!
    weak var progressViewWidthConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.playerProviderStateDidChange(_:)),
            name: .PlayerProviderStateDidChange,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.playerProviderNowPayingInfoDidChange(_:)),
            name: .PlayerProviderNowPlayingInfoDidChange,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .PlayerProviderStateDidChange, object: nil)
        PlayerProvider.shared.podcastPlayer.removeTimeObserver(self)
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
        
        
        let playerView = UIView(frame: .zero)
        view.addSubview(playerView)
        self.playerView = playerView
        playerView.backgroundColor = UIColor.Siniar.brand1
        playerView.layer.cornerRadius = 8
        playerView.layer.masksToBounds = true
        playerView.isHidden = true
        playerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            playerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: -4)
        ])
        
        let imageView = UIImageView(frame: .zero)
        playerView.addSubview(imageView)
        self.episodeImageView = imageView
        imageView.layer.cornerRadius = 21
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 42),
            imageView.heightAnchor.constraint(equalToConstant: 42),
            imageView.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: 8),
            imageView.topAnchor.constraint(equalTo: playerView.topAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: playerView.bottomAnchor, constant: -8),
        ])
        
        let label = UILabel(frame: .zero)
        playerView.addSubview(label)
        self.episodeTitleLabel = label
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor.Siniar.neutral3
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
        
        let previousButton = UIButton(type: .system)
        playerView.addSubview(previousButton)
        previousButton.tintColor = UIColor.Siniar.neutral1
        previousButton.setImage(UIImage(named: "btn_previous")?.withRenderingMode(.alwaysOriginal), for: .normal)
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            previousButton.widthAnchor.constraint(equalToConstant: 24),
            previousButton.heightAnchor.constraint(equalToConstant: 24),
            previousButton.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 20),
            previousButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
        previousButton.addTarget(self, action: #selector(self.previousButtonTapped(_:)), for: .touchUpInside)
        
        let playButton = UIButton(type: .system)
        playerView.addSubview(playButton)
        self.playButton = playButton
        playButton.tintColor = UIColor.Siniar.neutral1
        playButton.setImage(UIImage(named: "btn_play")?.withRenderingMode(.alwaysOriginal), for: .normal)
        playButton.layer.cornerRadius = 16
        playerView.layer.masksToBounds = true
        playButton.layer.borderColor = UIColor.Siniar.brand2.cgColor
        playButton.layer.borderWidth = 1.0
        playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playButton.widthAnchor.constraint(equalToConstant: 32),
            playButton.heightAnchor.constraint(equalToConstant: 32),
            playButton.leadingAnchor.constraint(equalTo: previousButton.trailingAnchor, constant: 16),
            playButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
        playButton.addTarget(self, action: #selector(self.playButtonTapped(_:)), for: .touchUpInside)
        
        let nextButton = UIButton(type: .system)
        playerView.addSubview(nextButton)
        nextButton.tintColor = UIColor.Siniar.neutral1
        nextButton.setImage(UIImage(named: "btn_next")?.withRenderingMode(.alwaysOriginal), for: .normal)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.widthAnchor.constraint(equalToConstant: 24),
            nextButton.heightAnchor.constraint(equalToConstant: 24),
            nextButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: -8),
            nextButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
        nextButton.addTarget(self, action: #selector(self.nextButtonTapped(_:)), for: .touchUpInside)
        
        let progressView = UIView(frame: .zero)
        playerView.addSubview(progressView)
        self.progressView = progressView
        progressView.backgroundColor = UIColor.Siniar.brand2
        progressView.layer.cornerRadius = 1
        progressView.layer.masksToBounds = true
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.heightAnchor.constraint(equalToConstant: 2),
            progressView.bottomAnchor.constraint(equalTo: playerView.bottomAnchor),
            progressView.leadingAnchor.constraint(equalTo: playerView.leadingAnchor),
            progressView.trailingAnchor.constraint(lessThanOrEqualTo: playerView.trailingAnchor)
        ])
        let widthConstraint = progressView.widthAnchor.constraint(equalToConstant: 128)
        widthConstraint.priority = .defaultHigh
        widthConstraint.isActive = true
        self.progressViewWidthConstraint = widthConstraint
        
    }
    
    func showPlayerView() {
        playerView.isHidden = false
        
        viewControllers?.forEach({ viewController in
            if #available(iOS 11.0, *) {
                viewController.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 62, right: 0)
            }
            else {
                // Fallback on earlier versions
            }
        })
        
        let playerProvider = PlayerProvider.shared
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        playerProvider.podcastPlayer.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) { [weak self] (time) in
            guard let `self` = self, let currentItem = playerProvider.podcastPlayer.currentItem else {
                return
            }
            let currentSeconds = CMTimeGetSeconds(time)
            let totalSeconds = CMTimeGetSeconds(currentItem.duration)
            let progress: CGFloat = max(0.0001, CGFloat(currentSeconds / totalSeconds))
            
            self.progressViewWidthConstraint?.constant = self.playerView.bounds.width * progress
            self.view.setNeedsLayout()
        }
    }
    
    func hidePlayerView() {
        playerView.isHidden = true
        viewControllers?.forEach({ viewController in
            if #available(iOS 11.0, *) {
                viewController.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
            else {
                // Fallback on earlier versions
            }
        })
        PlayerProvider.shared.podcastPlayer.removeTimeObserver(self)
    }
    
    // MARK: - Actions
    
    @objc func previousButtonTapped(_ sender: Any) {
        PlayerProvider.shared.podcastPrevious()
    }
    
    @objc func playButtonTapped(_ sender: Any) {
        PlayerProvider.shared.podcastPlay()
    }
    
    @objc func nextButtonTapped(_ sender: Any) {
        PlayerProvider.shared.podcastNext()
    }
    
    @objc func playerProviderStateDidChange(_ sender: Notification) {
        playerProviderNowPayingInfoDidChange(sender)
        
        if playerView.isHidden {
            showPlayerView()
        }
    }
    
    @objc func playerProviderNowPayingInfoDidChange(_ sender: Notification) {
        let playerProvider = PlayerProvider.shared
        let episode = playerProvider.playlist?.items?[playerProvider.currentIndex]
        
        episodeTitleLabel.text = episode?.title
        episodeImageView.kf.setImage(with: URL(string: episode?.pictureUrl ?? ""))
        let buttonImage = UIImage(named: playerProvider.isPodcastPlaying() ? "btn_pause" : "btn_play")?.withRenderingMode(.alwaysOriginal)
        playButton.setImage(buttonImage, for: .normal)
        
    }
}

extension UIViewController {
    func showMainViewController() {
        let viewController = MainViewController()
        let  window = UIApplication.shared.windows.first { $0.isKeyWindow }
        window?.rootViewController = viewController
    }
}
