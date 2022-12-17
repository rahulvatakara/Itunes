//
//  APIManager.swift
//  Itunes
//
//  Created by Rahul C K on 09/12/22.
//

import Foundation

class APIManager: BaseAPIManager {

    let session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    /**
     Search items with term and media type
     */
    func search(term: String, mediaType: String, completion: @escaping (Result<SearchAPIResponse?, APIError>) -> Void) {
        let endpoint = AppFeed.search(term: term, mediaType: mediaType)
        var request = endpoint.request
        request.method = HTTPMethod.get
        fetch(with: request, decode: { json -> SearchAPIResponse? in
            guard let searchFeedResult = json as? SearchAPIResponse else { return  nil }
            return searchFeedResult
        }, completion: completion)
    }
}
