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

struct SearchResult: Codable, Equatable {
    
    static func ==(lhs: SearchResult, rhs: SearchResult) -> Bool {
        if lhs.artistName != rhs.artistName {
            return false
        }
        if lhs.trackName != rhs.trackName {
            return false
        }
        if lhs.releaseDate != rhs.releaseDate {
            return false
        }
        if lhs.trackPrice != rhs.trackPrice {
            return false
        }
        if lhs.primaryGenreName != rhs.primaryGenreName {
            return false
        }
        return true
    }
    
    var artistName: String? = ""
    var trackName: String? = ""
    var releaseDate: String? = ""
    var trackPrice: Double? = 0.0
    var primaryGenreName: String? = ""
}
