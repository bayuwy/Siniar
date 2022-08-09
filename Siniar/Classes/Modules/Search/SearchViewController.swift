//
//  SearchViewController.swift
//  Siniar
//
//  Created by Bayu Yasaputro on 06/08/22.
//

import UIKit

class SearchViewController: UIViewController {
    weak var tableView: UITableView!
    weak var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        title = "Search"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
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
        tableView.register(MusicViewCell.self, forCellReuseIdentifier: "musicCellId")
        tableView.dataSource = self
//        tableView.delegate = self
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = UIColor.Siniar.neutral1
        searchController.searchBar.barStyle = .black
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        }
        else {
            // Fallback on earlier versions
            
        }
        self.searchController = searchController
        searchController.searchBar.delegate = self
        
    }

}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCellId", for: indexPath) as! MusicViewCell
        
        cell.noLabel.isHidden = true
        cell.thumbImageView.image = UIImage(named: "img_ftux3")
        cell.titleLabel.text = "Music at index \(indexPath.row)"
        cell.subtitleLabel.isHidden = true
        
//        cell.delegate = self
        
        return cell
    }
    
    // MARK: - Helpers
    
    func search(_ q: String) {
        print("Search with key word: \(q)")
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let q = searchBar.text?
            .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
            !q.isEmpty {
            search(q)
        }
        else {
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let string = NSString(string: searchBar.text ?? "").replacingCharacters(in: range, with: text)
            .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if string.count >= 3 {
            search(string)
        }
        return true
    }
}
