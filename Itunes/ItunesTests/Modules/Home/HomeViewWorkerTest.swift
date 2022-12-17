//
//  HomeViewWorkerTest.swift
//  ItunesTests
//
//  Created by RAHUL CK on 12/17/22.
//

import Foundation
import XCTest
@testable import Itunes

final class HomeViewWorkerTest: XCTestCase {
    var sut: HomeViewWorker!
    var mockApiManager: MockAPIManager!

    override func setUpWithError() throws {
        mockApiManager = MockAPIManager()
        sut = HomeViewWorker(apiManager: mockApiManager)
    }

    override func tearDownWithError() throws {
        mockApiManager = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testSearch_Success() {
        let mockTerm = "term"
        let mockMediaType = "mediaType"

        sut.searchItem(term: mockTerm,
                       mediaType: mockMediaType) { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)

            case .failure(let failure):
                XCTAssertNil(failure)
            }
        }

        XCTAssertEqual(mockApiManager.searchCalledCount, 1)
    }

    func testSearch_Fail() {
        let mockTerm = "term"
        let mockMediaType = "mediaType"
        mockApiManager.searchApiShouldSuccess = false

        sut.searchItem(term: mockTerm,
                       mediaType: mockMediaType) { result in
            switch result {
            case .success(let response):
                XCTAssertNil(response)

            case .failure(let failure):
                XCTAssertNotNil(failure)
            }
        }

        XCTAssertEqual(mockApiManager.searchCalledCount, 1)
    }
}
