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
    }
    
    func getUrl(searchText: String) {
        let urlString = String("https://itunes.apple.com/search?term=" + "\(searchBar.text!)&limit=1000")
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.global().async {
                    self.parse(json: data)
                }
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonResults = try? decoder.decode(Results.self, from: json) {
            results = jsonResults.results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !searchBar.text!.isEmpty {
            searchBar.becomeFirstResponder()
            results = []
            self.showSpinner()
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) {_ in
                self.getUrl(searchText: searchBar.text!)
                self.results.sort { (resultA, resultB) -> Bool in
                    return resultA.artistName?.localizedStandardCompare(resultB.artistName!) == .orderedAscending
                }
                self.tableView.reloadData()
                self.removeSpinner()
            }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.searchResultCell, for: indexPath) as! ResultCell
        cell.artistNameLabel.text = "Artist Name: \(results[indexPath.row].artistName ?? "Not found")"
        cell.trackNameLabel.text = "Track Name: \(results[indexPath.row].trackName ?? "Not found")"
        cell.trackPriceLabel.text = "Track Price: $\(results[indexPath.row].trackPrice ?? 0)"
        cell.primaryGenreLabel.text = "Primary Genre: \(results[indexPath.row].primaryGenreName ?? "Not found")"
        cell.releaseDateLabel.text = "Release Date: \(String(results[indexPath.row].releaseDate!))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if results.count == 0 {
            return nil
        } else {
            return indexPath
        }
    }
}

