//
//  HomeViewRouter.swift
//  Itunes
//
//  Created by Rahul C K on 09/12/22.
//

import Foundation
protocol HomeViewRoutingLogic: AnyObject {
    static func createHomeViewModule(homeviewRef: HomeViewController)
    func showMediaTypePicker(sourceView: HomeViewController)
    func showSearchResultView(sourceView: HomeViewController, searchResults: [String: [SearchItem]])
}

class HomeViewRouter: HomeViewRoutingLogic {
     static func createHomeViewModule(homeviewRef: HomeViewController) {
         let interactor = HomeViewInteractor()
         interactor.worker = HomeViewWorker()
         let presentor = HomeViewPresenter()
         presentor.view = homeviewRef
         interactor.presentor = presentor
         homeviewRef.router = HomeViewRouter()
         homeviewRef.interactor = interactor
    }

    func showMediaTypePicker(sourceView: HomeViewController) {
        guard let mediaTypeViewController = MediaTypePickerViewController.instantiateViewController() else { return }
        mediaTypeViewController.delegate = sourceView
        sourceView.navigationController?.pushViewController(mediaTypeViewController, animated: true)

    }

    func showSearchResultView(sourceView: HomeViewController, searchResults: [String: [SearchItem]]) {
        guard let searchResultVC = SearchResultViewController.instantiateViewController() else { return }
        SearchResultRouter.createSearchResultViewModule(searchResultViewRef: searchResultVC,
                                                        searchResults: searchResults)
        sourceView.navigationController?.pushViewController(searchResultVC, animated: true)
    }

}
