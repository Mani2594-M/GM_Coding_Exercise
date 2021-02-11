//
//  SearchResult.swift
//  GM_Coding_Exercise
//
//  Created by Mani V on 2/11/21.
//

import Foundation

struct Results: Codable {
    var results = [SearchResult]()
}

struct SearchResult: Codable {
    var artistName: String?
    var trackName: String?
    var releaseDate: String?
    var trackPrice: Double?
    var primaryGenreName: String?
}
