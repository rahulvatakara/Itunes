//
//  HomeViewInteractor.swift
//  Itunes
//
//  Created by Rahul C K on 09/12/22.
//

import Foundation

protocol HomeViewBussinessLogic: AnyObject {
    var presentor: HomeViewPresentingLogic? { get set }
    var worker: HomeViewWorkerLogic? { get set }
    func searchItems(term: String?, mediaTypes: [String])
}

class HomeViewInteractor: HomeViewBussinessLogic {
    var presentor: HomeViewPresentingLogic?
    var worker: HomeViewWorkerLogic?
    let group = DispatchGroup()
    var searchResults: [String: [SearchItem]] = [:]

    func searchItems(term: String?, mediaTypes: [String]) {
        guard let term = term, term.count > 0 else {
            presentor?.showSeachFailed(error: nil)
            return
        }

        guard mediaTypes.count > 0 else {
            presentor?.showSeachFailed(error: nil)
            return
        }

        presentor?.updateUIFor(isLoading: true)
        mediaTypes.forEach {
            group.enter()
            searchItems(term: term, mediaType: $0)
        }
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.presentor?.updateUIFor(isLoading: false)
            self.presentor?.showSearchResults(items: self.searchResults)
        }
    }
    private func searchItems(term: String, mediaType: String) {
        worker?.searchItem(term: term, mediaType: mediaType, completion: { [weak self] searchResponse in
            guard let self = self else { return }
            switch searchResponse {
            case .success(let searchItems):
                self.searchResults[mediaType] = searchItems
            case .failure:
                break
            }
            self.group.leave()
        })
    }
}
