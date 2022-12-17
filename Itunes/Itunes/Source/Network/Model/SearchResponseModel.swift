//
//  SearchResponseModel.swift
//  Itunes
//
//  Created by Rahul C K on 09/12/22.
//

import Foundation

struct SearchAPIResponse: Codable {
    let resultCount: Int
    let results: [SearchItem]
}

struct SearchItem: Codable {
        let artistID, collectionID, trackID: Int?
        let artistName, collectionName, trackName, collectionCensoredName: String?
        let trackCensoredName: String?
        let artistViewURL, collectionViewURL, trackViewURL: String?
        let previewURL: String?
        let artworkUrl30, artworkUrl60, artworkUrl100: String?
        let collectionPrice, trackPrice: Double?
        let discCount, discNumber, trackCount, trackNumber: Int?
        let trackTimeMillis: Int?
        let primaryGenreName, contentAdvisoryRating: String?

        enum CodingKeys: String, CodingKey {
            case artistID = "artistId"
            case collectionID = "collectionId"
            case trackID = "trackId"
            case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
            case artistViewURL = "artistViewUrl"
            case collectionViewURL = "collectionViewUrl"
            case trackViewURL = "trackViewUrl"
            case previewURL = "previewUrl"
            case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice
            case trackPrice, discCount, discNumber, trackCount, trackNumber
            case trackTimeMillis, primaryGenreName, contentAdvisoryRating
        }

    func imageUrl() -> String? {
        artworkUrl30 ?? artworkUrl60 ?? artworkUrl100
    }
    func title() -> String {
        artistName ?? trackName ?? ""
    }
    func subTitle() -> String {
        collectionName ?? primaryGenreName ?? trackCensoredName ?? ""
    }
}
