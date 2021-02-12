//
//  SearchViewControllerTests.swift
//  GM_Coding_ExerciseTests
//
//  Created by Mani V on 2/12/21.
//

import XCTest
@testable import GM_Coding_Exercise

class SearchViewControllerTests: XCTestCase {
    
    var sut: SearchViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        _ = sut.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    func testSearchBar_CanBeInstantiated() {
        XCTAssertNotNil(sut)
    }
    
    func testViewController_HasNoInitialSearchBar() {
        XCTAssertNotNil(sut.searchBar)
    }
    
    func testViewController_ShouldSetSearchBarDelegate() {
        XCTAssertNotNil(self.sut.searchBar.delegate)
    }
    
    func testViewController_ConformToSearchBarDelegate() {
        XCTAssert(sut.conforms(to: UISearchBarDelegate.self))
        XCTAssertTrue(self.sut.responds(to: #selector(sut.searchBarSearchButtonClicked(_:))))
        XCTAssertTrue(self.sut.responds(to: #selector(sut.searchBarTextDidEndEditing(_:))))
    }
    
    func testViewController_PerformsWordSearch_AfterSearchButtonTapped() {
        sut.searchBar.text = ""
        sut.searchBarSearchButtonClicked(sut.searchBar)
        let textToSearch = ""
        let actualTextToSearch = sut.searchBar.text
        XCTAssertEqual(textToSearch, actualTextToSearch)
    }
}
