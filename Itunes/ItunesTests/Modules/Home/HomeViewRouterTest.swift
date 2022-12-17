//
//  HomeViewRouterTest.swift
//  ItunesTests
//
//  Created by RAHUL CK on 12/17/22.
//

import Foundation
import XCTest
@testable import Itunes

final class HomeViewRouterTest: XCTestCase {
    var sut: HomeViewRouter!

    override func setUpWithError() throws {
        sut = HomeViewRouter()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testSearch_Success() throws {
        let homeVC = try XCTUnwrap(HomeViewController.instantiateViewController())

        HomeViewRouter.createHomeViewModule(homeviewRef: homeVC)

        XCTAssertNotNil(homeVC.interactor)
        XCTAssertNotNil(homeVC.router)
    }

    func testShowMediaTypePicker() throws {
        let homeVC = try XCTUnwrap(HomeViewController.instantiateViewController())
        let mockNavigationVC = MockNavigationController(rootViewController: homeVC)

        sut.showMediaTypePicker(sourceView: homeVC)

        XCTAssertNotNil(mockNavigationVC.pushedController as? MediaTypePickerViewController)
    }

    func testShowSearchResult() throws {
        let homeVC = try XCTUnwrap(HomeViewController.instantiateViewController())
        let mockNavigationVC = MockNavigationController(rootViewController: homeVC)

        sut.showSearchResultView(sourceView: homeVC, searchResults: [:])

        XCTAssertNotNil(mockNavigationVC.pushedController as? SearchResultViewController)
    }
}
