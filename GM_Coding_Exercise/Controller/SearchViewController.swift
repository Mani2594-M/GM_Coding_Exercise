//
//  SearchViewController.swift
//  GM_Coding_Exercise
//
//  Created by Mani V on 2/11/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    var results = [SearchResult]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        getUrl(searchText: searchBar.text!)
        
        let nib = UINib.init(nibName: "LoadingCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "LoadingCell")
    }
    
    func getUrl(searchText: String) {
        let urlString = String("https://itunes.apple.com/search?term=" + "\(searchBar.text!)")
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonResults = try? decoder.decode(Results.self, from: json) {
            results = jsonResults.results
            print(results)
            tableView.reloadData()
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !searchBar.text!.isEmpty {
            searchBar.resignFirstResponder()
            results = []
            getUrl(searchText: searchBar.text!)
            tableView.reloadData()
        }
        results.sort { (resultA, resultB) -> Bool in
            return resultA.artistName?.localizedStandardCompare(resultB.artistName!) == .orderedAscending
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ResultCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ResultCell
        cell.artistNameLabel.text = "Artist Name: \(results[indexPath.row].artistName!)"
        cell.trackNameLabel.text = "Track Name: \(results[indexPath.row].trackName!)"
        cell.trackPriceLabel.text = "Track Price: $\(results[indexPath.row].trackPrice!)"
        cell.primaryGenreLabel.text = "Primary Genre: \(results[indexPath.row].primaryGenreName!)"
        cell.releaseDateLabel.text = "Release Date: \(String(results[indexPath.row].releaseDate!))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
