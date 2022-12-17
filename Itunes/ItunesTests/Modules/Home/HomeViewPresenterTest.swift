//
//  HomeViewPresenterTest.swift
//  ItunesTests
//
//  Created by RAHUL CK on 12/17/22.
//

import Foundation
import XCTest
@testable import Itunes

class MockHomeViewController: HomeViewUILogic {
    var interactor: Itunes.HomeViewBussinessLogic?
    var router: Itunes.HomeViewRoutingLogic?
    public var showSearchResultsCalled: Int = 0
    public var showSeachFailedCalled: Int = 0
    public var updateUIForCalled: Int = 0

    func showSearchResults(items: [String: [SearchItem]]) {
        showSearchResultsCalled += 1
    }
    func updateUIFor(isLoading: Bool) {
        updateUIForCalled += 1
    }
    func showSeachFailedError() {
        showSeachFailedCalled += 1
    }
}
final class HomeViewPresenterTest: XCTestCase {
    var sut: HomeViewPresenter!
    var mockView: MockHomeViewController!

    override func setUpWithError() throws {
        mockView = MockHomeViewController()
        sut = HomeViewPresenter()
        sut.view = mockView
    }

    override func tearDownWithError() throws {
        mockView = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testShowSeachFailed() {
        sut.showSeachFailed(error: nil)

        XCTAssertEqual(mockView.showSeachFailedCalled, 1)
    }

    func testUpdateUIFor() {
        sut.updateUIFor(isLoading: true)

        XCTAssertEqual(mockView.updateUIForCalled, 1)
    }

    func testShowSearchResults_Empty() {
        sut.showSearchResults(items: [:])

        XCTAssertEqual(mockView.showSeachFailedCalled, 1)
    }

    func testShowSearchResults_nonEmpty() {
        let mockSearchItems = MockAPIManager().mockSearchResultResponse().results

        sut.showSearchResults(items: ["section1": mockSearchItems])

        XCTAssertEqual(mockView.showSearchResultsCalled, 1)
    }
}
