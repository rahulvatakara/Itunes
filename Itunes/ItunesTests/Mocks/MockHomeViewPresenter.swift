//
//  MockHomeViewPresenter.swift
//  ItunesTests
//
//  Created by RAHUL CK on 12/17/22.
//
@testable import Itunes
class MockHomeViewPresenter: HomeViewPresentingLogic {
    var view: Itunes.HomeViewUILogic?
    public var showSearchResultsCalled: Int = 0
    public var showSeachFailedCalled: Int = 0
    public var updateUIForCalled: Int = 0

    func showSearchResults(items: [String: [Itunes.SearchItem]]) {
        showSearchResultsCalled += 1
    }

    func showSeachFailed(error: Error?) {
        showSeachFailedCalled += 1
    }

    func updateUIFor(isLoading: Bool) {
        updateUIForCalled += 1
    }
}
