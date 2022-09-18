//
//  NetworkRequestable.swift
//  
//
//  Created by Vishweshwaran on 07/09/22.
//

import Foundation

public protocol NetworkRequestable {
    var url: URL { get throws }
    var host: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var queryParameter: [String: AnyHashable]? { get }
}

/// Protocol Extension for constructing `URL`
public extension NetworkRequestable {
    
    var url: URL {
        get throws {
            var urlComponent = URLComponents()
            urlComponent.scheme = "https"
            urlComponent.host = host
            urlComponent.path = path
            guard let url = urlComponent.url else { throw URLError(.badURL) }
            return url.addQueryParamIfNeeded(queryParameter)
        }
    }
}
