//
//  SearchResultInteractorTest.swift
//  ItunesTests
//
//  Created by RAHUL CK on 12/18/22.
//

import XCTest
@testable import Itunes

final class SearchResultInteractorTest: XCTestCase {
    var sut: SearchResultInteractor!
    var mockPresenter: MockSearchResultPresenter!

    override func setUpWithError() throws {
        mockPresenter = MockSearchResultPresenter()
        let searchResults = MockAPIManager().mockSearchResultResponse().results
        sut = SearchResultInteractor(searchResults: ["section 1": searchResults])
        sut.worker = SearchResultWorker()
        sut.presentor = mockPresenter
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        mockPresenter = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testInit() {
        XCTAssertEqual(sut.searchResults.count, 1)
    }

    func testOnLayoutChangedAction() {
        sut.onLayoutChangedAction(currentLayout: .list)

        XCTAssertEqual(mockPresenter.newLayout, .grid)
    }

    func testNumberOfSections() {
        XCTAssertEqual(sut.numberOfSection(), 1)
    }

    func testNumberOfSearchResultItem() {
        XCTAssertEqual(sut.numberOfSearchResultItem(for: 0), 50)
    }

    func testSearchResultItemAt() {
        let searchItem = sut.searchResultItemAt(section: 0, index: 1)

        XCTAssertEqual(searchItem.artistName, "Martin Solveig & Dragonette")
        XCTAssertEqual(searchItem.artistID, 15201848)
        XCTAssertEqual(searchItem.collectionCensoredName, "Hello - Single")
        XCTAssertEqual(searchItem.artworkUrl30, nil)
        XCTAssertEqual(searchItem.discCount, nil)
        XCTAssertEqual(searchItem.trackID, nil)
        XCTAssertEqual(searchItem.trackCensoredName, nil)
    }

    func testTitle() {
        XCTAssertEqual(sut.title(for: 0), "SECTION 1")
    }
}
