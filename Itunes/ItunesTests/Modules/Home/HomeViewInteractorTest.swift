//
//  HomeViewInteractorTest.swift
//  ItunesTests
//
//  Created by RAHUL CK on 12/17/22.
//

import XCTest
@testable import Itunes

final class HomeViewInteractorTest: XCTestCase {
    var sut: HomeViewInteractor!
    var mockWorker: MockHomeViewWorker!
    var mockPresenter: MockHomeViewPresenter!

    override func setUpWithError() throws {
        mockWorker = MockHomeViewWorker()
        mockPresenter = MockHomeViewPresenter()
        sut = HomeViewInteractor()
        sut.worker = mockWorker
        sut.presentor = mockPresenter
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        mockWorker = nil
        mockPresenter = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testSearchItems_term_nil() {
        let mockMediaType = ["MediaType1", "MediaType2"]

        sut.searchItems(term: nil, mediaTypes: mockMediaType)

        XCTAssertEqual(mockPresenter.showSeachFailedCalled, 1)
    }

    func testSearchItems_term_empty() {
        let mockMediaType = ["MediaType1", "MediaType2"]

        sut.searchItems(term: "", mediaTypes: mockMediaType)

        XCTAssertEqual(mockPresenter.showSeachFailedCalled, 1)
    }

    func testSearchItems_mediaTypes_empty() {
        let mockTerm = "term"

        sut.searchItems(term: mockTerm, mediaTypes: [])

        XCTAssertEqual(mockPresenter.showSeachFailedCalled, 1)
    }

    func testSearchItems_nomEmptyTerm_nonEmptyMediaTypes() {
        let mockTerm = "term"
        let mockMediaType = ["MediaType1", "MediaType2"]

        sut.searchItems(term: mockTerm, mediaTypes: mockMediaType)

        XCTAssertEqual(mockPresenter.updateUIForCalled, 1)
        XCTAssertEqual(mockWorker.searchItemCalledCount, 2)
        XCTAssertEqual(mockWorker.term, mockTerm)
    }
}
