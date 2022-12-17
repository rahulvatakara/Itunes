//
//  URLRequestExtension.swift
//  Itunes
//
//  Created by Rahul C K on 09/12/22.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    case trace = "TRACE"
    case connect = "CONNECT"
}
extension URLRequest {
    public var method: HTTPMethod? {
        get {
            guard let httpMethod = self.httpMethod else { return nil }
            let method = HTTPMethod(rawValue: httpMethod)
            return method
        }

        set {
            self.httpMethod = newValue?.rawValue
        }
    }
}
