//
//  SearchResultPresenterTest.swift
//  ItunesTests
//
//  Created by RAHUL CK on 12/18/22.
//

import XCTest
@testable import Itunes
private class MockSearchResultController: SearchResultUILogic {
    var interactor: Itunes.SearchResultBussinessLogic?
    public var onLayoutChangededCalled: Int = 0
    public var newLayout: Itunes.SearchResultViewLayout?

    var router: Itunes.SearchResultRoutingLogic?

    func onLayoutChanged(newLayout: Itunes.SearchResultViewLayout) {
        self.newLayout = newLayout
        onLayoutChangededCalled += 1
    }
}

final class SearchResultPresenterTest: XCTestCase {
    var sut: SearchResultPresenter!

    override func setUpWithError() throws {
        sut = SearchResultPresenter()
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testOnLayoutChanged() {
        let mockView = MockSearchResultController()
        sut.view = mockView

        sut.onLayoutChanged(newLayout: .grid)

        XCTAssertEqual(mockView.onLayoutChangededCalled, 1)
        XCTAssertEqual(mockView.newLayout, .grid)
    }
}
