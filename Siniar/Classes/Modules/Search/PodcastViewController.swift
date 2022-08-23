//
//  PodcastViewController.swift
//  Siniar
//
//  Created by Bayu Yasaputro on 23/08/22.
//

import UIKit
import Kingfisher
import FeedKit

class PodcastViewController: UIViewController {
    weak var tableView: UITableView!
    
    var podcast: Podcast!
    var rssFeed: RSSFeed?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        loadData()
    }
    
    func setup() {
        view.backgroundColor = UIColor.Siniar.brand2
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        view.addSubview(tableView)
        self.tableView = tableView
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.register(PodcastDetailViewCell.self, forCellReuseIdentifier: "detailCellId")
        tableView.register(EpisodeViewCell.self, forCellReuseIdentifier: "episodeCellId")
        tableView.dataSource = self
        
        let backButton = UIButton(type: .system)
        view.addSubview(backButton)
        backButton.setImage(UIImage(named: "btn_back")?.withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.setTitle(nil, for: .normal)
        backButton.layer.cornerRadius = 12
        backButton.layer.masksToBounds = true
        backButton.backgroundColor = UIColor.Siniar.brand2.withAlphaComponent(0.6)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 24)
        ])
        backButton.addTarget(self, action: #selector(self.backButtonTapped(_:)), for: .touchUpInside)
    }
    
    func loadData() {
        ApiProvider.shared.loadFromFeedUrl(podcast.feedUrl) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .success(let feed):
                self.rssFeed = feed
                self.tableView.reloadData()
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Oke", style: .default))
                self.present(alert, animated: true)
            }
        }
    }

    @objc func backButtonTapped(_ sender: Any) {
       dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension PodcastViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return rssFeed?.items?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCellId", for: indexPath) as! PodcastDetailViewCell
            
            cell.artworkImageView.kf.setImage(with: URL(string: podcast.artworkUrl600))
            cell.titleLabel.text = podcast.collectionName
            cell.subtitleLabel.text = podcast.artistName
            cell.descTextView.text = "Lorem ipsum dolor "
            cell.genreLabel.text = podcast.genres.joined(separator: " • ")
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCellId", for: indexPath) as! EpisodeViewCell
            
            let episode = rssFeed?.items?[indexPath.row]
            let urlString = episode?.iTunes?.iTunesImage?.attributes?.href ?? ""
            cell.episodeImageView.kf.setImage(with: URL(string: urlString))
            cell.dateLabel.text = episode?.pubDate?.string(format: "d MMM yyyy")
            cell.titleLabel.text = episode?.title
            cell.descTextView.attributedText = episode?.description?
                .convertHtmlToAttributedStringWithCSS(
                    font: UIFont.systemFont(ofSize: 12, weight: .regular),
                    cssColor: "#EEEEEE",
                    lineHeight: 16,
                    cssTextAlign: "left"
                )
            cell.durationLabel.text = episode?.iTunes?.iTunesDuration?.durationString
            
            return cell
        }
        
    }
}

// MARK: - UIViewController
extension UIViewController {
    func showPodcastViewController(_ podcast: Podcast) {
        let viewController = PodcastViewController()
        viewController.podcast = podcast
        present(viewController, animated: true)
    }
}
