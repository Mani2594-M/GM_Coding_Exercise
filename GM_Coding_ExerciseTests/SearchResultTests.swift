//
//  SearchResultTests.swift
//  GM_Coding_ExerciseTests
//
//  Created by Mani V on 2/12/21.
//

import XCTest
@testable import GM_Coding_Exercise

class SearchResultTests: XCTestCase {
    
    var sut: SearchResult!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = SearchResult()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    func testInit_WhenGivenValues_TakesValues() {
        let searchResult1 = SearchResult(artistName: "Taylor", trackName: "Love Story", releaseDate: "2008", trackPrice: 9.99, primaryGenreName: "Romance")
        let searchResult2 = SearchResult(artistName: "Taylor", trackName: "Love Story", releaseDate: "2008", trackPrice: 9.99, primaryGenreName: "Romance")
        let searchResult3 = SearchResult(artistName: "Metallica", trackName: "Rock and Roll", releaseDate: "2008", trackPrice: 9.99, primaryGenreName: "Romance")
        XCTAssertEqual(searchResult1, searchResult2)
        XCTAssertNotEqual(searchResult2, searchResult3)
    }
    
    func testValues_AreInitiallyEmpty() {
        XCTAssertEqual(sut.artistName, "")
        XCTAssertEqual(sut.trackPrice, 0.0)
        XCTAssertEqual(sut.primaryGenreName, "")
        XCTAssertEqual(sut.releaseDate, "")
    }
}
