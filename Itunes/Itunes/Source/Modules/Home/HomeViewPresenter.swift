//
//  HomeViewPresenter.swift
//  Itunes
//
//  Created by Rahul C K on 09/12/22.
//

import Foundation
protocol HomeViewPresentingLogic: AnyObject {
    var view: HomeViewUILogic? { get set }
    func showSearchResults(items: [String: [SearchItem]])
    func showSeachFailed(error: Error?)
    func updateUIFor(isLoading: Bool)
}

class HomeViewPresenter: HomeViewPresentingLogic {
    weak var view: HomeViewUILogic?

    func showSearchResults(items: [String: [SearchItem]]) {
        if items.count > 0 {
            view?.showSearchResults(items: items)
        } else {
            view?.showSeachFailedError()
        }
    }

    func updateUIFor(isLoading: Bool) {
        view?.updateUIFor(isLoading: isLoading)
    }

    func showSeachFailed(error: Error?) {
        view?.showSeachFailedError()
    }
}
