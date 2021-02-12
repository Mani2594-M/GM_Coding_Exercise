//
//  DownloadDataTests.swift
//  GM_Coding_ExerciseTests
//
//  Created by Mani V on 2/12/21.
//

import XCTest
@testable import GM_Coding_Exercise

class DownloadDataTests: XCTestCase {
    
    var sut: SearchViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "SearchViewController") as? SearchViewController
        _ = sut.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    func testDownload_ForExpectedHost() {
        //let urlString = String("https://itunes.apple.com/search?term=Metallica" + "\(sut.searchBar.text!)")
        let urlString = String("https://itunes.apple.com/search?term=" + "\(sut.searchBar.text!)")
        let url = URL(string: urlString)!
        sut.getUrl(searchText: sut.searchBar.text!)
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        XCTAssertEqual(urlComponents?.host, "itunes.apple.com")
    }
    
    func testDownload_ForExpectedPath() {
        let urlString = String("https://itunes.apple.com/search?term=Metallica")
        let url = URL(string: urlString)!
        sut.getUrl(searchText: sut.searchBar.text!)
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        XCTAssertEqual(urlComponents?.path, "/search")
    }
}

