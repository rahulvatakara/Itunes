//
//  HomeViewPresenter.swift
//  Itunes
//
//  Created by Rahul C K on 09/12/22.
//

import Foundation
protocol SearchResultPresentingLogic: AnyObject {
    var view: SearchResultUILogic? { get set }
    func onLayoutChanged(newLayout: SearchResultViewLayout)
}

class SearchResultPresenter: SearchResultPresentingLogic {
    weak var view: SearchResultUILogic?

    func onLayoutChanged(newLayout: SearchResultViewLayout) {
        view?.onLayoutChanged(newLayout: newLayout)
    }
}
