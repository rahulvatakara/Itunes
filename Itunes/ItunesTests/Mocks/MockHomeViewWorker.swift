//
//  MockHomeViewWorker.swift
//  ItunesTests
//
//  Created by RAHUL CK on 12/17/22.
//

@testable import Itunes

class MockHomeViewWorker: HomeViewWorkerLogic {
    public var term: String = ""
    public var mediaType: String = ""
    public var searchItemCalledCount: Int = 0

    func searchItem(term: String, mediaType: String,
                    completion: @escaping (Result<[Itunes.SearchItem]?, Error>) -> Void) {
        self.term = term
        self.mediaType = mediaType
        searchItemCalledCount += 1
        let response = MockAPIManager().mockSearchResultResponse().results
        completion(Result.success(response))
    }
}
