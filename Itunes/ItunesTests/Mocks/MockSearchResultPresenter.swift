//
//  MockSearchResultPresenter.swift
//  ItunesTests
//
//  Created by RAHUL CK on 12/18/22.
//

import Foundation
@testable import Itunes
class MockSearchResultPresenter: SearchResultPresentingLogic {
    var view: Itunes.SearchResultUILogic?
    public var onLayoutChangedCalled: Int = 0
    public var newLayout: Itunes.SearchResultViewLayout?

    func onLayoutChanged(newLayout: Itunes.SearchResultViewLayout) {
        self.newLayout = newLayout
        onLayoutChangedCalled += 1
    }
}
