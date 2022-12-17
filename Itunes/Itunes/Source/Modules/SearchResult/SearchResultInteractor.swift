//
//  HomeViewInteractor.swift
//  Itunes
//
//  Created by Rahul C K on 09/12/22.
//

import Foundation

protocol SearchResultBussinessLogic: AnyObject {
    var presentor: SearchResultPresentingLogic? { get set }
    var worker: SearchResultWorkerLogic? { get set }
    func onLayoutChangedAction(currentLayout: SearchResultViewLayout)
    func numberOfSection() -> Int
    func numberOfSearchResultItem(for section: Int) -> Int
    func searchResultItemAt(section: Int, index: Int) -> SearchItem
    func title(for section: Int) -> String
}

class SearchResultInteractor: SearchResultBussinessLogic {
    var presentor: SearchResultPresentingLogic?
    var worker: SearchResultWorkerLogic?
    var searchResults: [String: [SearchItem]]
    private var mediaTypes: [String]

    init(presentor: SearchResultPresentingLogic? = nil,
         worker: SearchResultWorkerLogic? = nil,
         searchResults: [String: [SearchItem]]) {
        self.presentor = presentor
        self.worker = worker
        self.searchResults = searchResults
        self.mediaTypes = searchResults.keys.compactMap { $0 }
    }

    func onLayoutChangedAction(currentLayout: SearchResultViewLayout) {
        let newLayout: SearchResultViewLayout = (currentLayout == .grid) ? .list : .grid
        presentor?.onLayoutChanged(newLayout: newLayout)
    }

    func numberOfSection() -> Int {
        mediaTypes.count
    }

    func numberOfSearchResultItem(for section: Int) -> Int {
        searchResults[mediaTypes[section]]?.count ?? 0
    }

    func searchResultItemAt(section: Int, index: Int) -> SearchItem {
        searchResults[mediaTypes[section]]![index]
    }

    func title(for section: Int) -> String {
        mediaTypes[section].uppercased()
    }
}
