//
//  MockAPIManager.swift
//  ItunesTests
//
//  Created by RAHUL CK on 12/17/22.
//

import Foundation
@testable import Itunes
// swiftlint:disable force_try
class MockAPIManager: APIManager {
    public var searchCalledCount: Int = 0
    public var searchApiShouldSuccess: Bool = true

    override func search(term: String, mediaType: String,
                         completion: @escaping (Result<SearchAPIResponse?, APIError>) -> Void) {
        searchCalledCount += 1
        if searchApiShouldSuccess {
            let response = mockSearchResultResponse()
            completion(Result.success(response))
        } else {
            let response = mockSearchResultResponse()
            let error = APIError.invalidData
            completion(Result.failure(error))
        }
    }

    public func mockSearchResultResponse() -> SearchAPIResponse {
        let jsonData = getData(name: "SearchResultResponse")
        let homeData = try! JSONDecoder().decode(SearchAPIResponse.self, from: jsonData)
        return homeData
    }

    private func getData(name: String, withExtension: String = "json") -> Data {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
        let data = try! Data(contentsOf: fileUrl!)
        return data
    }
}
// swiftlint:enable force_try
