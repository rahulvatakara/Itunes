//
//  HomeViewRouter.swift
//  Itunes
//
//  Created by Rahul C K on 09/12/22.
//

import Foundation
protocol SearchResultRoutingLogic: AnyObject {
    static func createSearchResultViewModule(searchResultViewRef: SearchResultViewController,
                                             searchResults: [String: [SearchItem]])
    func showMediaTypePicker(sourceView: HomeViewController)
}

class SearchResultRouter: SearchResultRoutingLogic {
    static func createSearchResultViewModule(searchResultViewRef: SearchResultViewController,
                                             searchResults: [String: [SearchItem]]) {
        let interactor = SearchResultInteractor(searchResults: searchResults)
        interactor.worker = SearchResultWorker()
        let presentor = SearchResultPresenter()
        presentor.view = searchResultViewRef
        interactor.presentor = presentor
        searchResultViewRef.router = SearchResultRouter()
        searchResultViewRef.interactor = interactor
    }

    func showMediaTypePicker(sourceView: HomeViewController) {
        guard let mediaTypeVC = MediaTypePickerViewController.instantiateViewController() else { return }
        mediaTypeVC.delegate = sourceView
        sourceView.navigationController?.pushViewController(mediaTypeVC, animated: true)
    }
}
