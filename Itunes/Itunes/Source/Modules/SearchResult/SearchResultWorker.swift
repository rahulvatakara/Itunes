//
//  HomeViewWorker.swift
//  Itunes
//
//  Created by Rahul C K on 09/12/22.
//

import Foundation
protocol SearchResultWorkerLogic: AnyObject {
    func searchItem(term: String, mediaType: String, completion: @escaping (Result<[SearchItem]?, Error>) -> Void)
}
class SearchResultWorker: SearchResultWorkerLogic {
    let apiManager: APIManager

    public init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }

    func searchItem(term: String, mediaType: String, completion: @escaping (Result<[SearchItem]?, Error>) -> Void) {
        apiManager.search(term: term, mediaType: mediaType) { result in
            switch result {
            case .success(let response):
                completion(.success(response?.results))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
