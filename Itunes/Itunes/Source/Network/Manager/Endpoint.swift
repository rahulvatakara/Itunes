//
//  EndPoints.swift
//  Itunes
//
//  Created by Rahul C K on 09/12/22.
//
import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var query: String { get }
    var method: HTTPMethod { get }
}

extension Endpoint {
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.query = query
        return components
    }

    var request: URLRequest {
        let url = urlComponents.url!
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}

enum AppFeed {
    case search(term: String, mediaType: String)
}
extension AppFeed: Endpoint {
    var method: HTTPMethod {
        return .get
    }
    var base: String {
        return "https://itunes.apple.com"
    }
    var query: String {
        switch self {
        case let .search(term, mediaType):
            return "term=\(term)&entity=\(mediaType)"
        }
    }

    var path: String {
        switch self {
        case .search:
            return "/search"
        }
    }
}
