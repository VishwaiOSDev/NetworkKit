//
//  URL+Extension.swift
//  
//
//  Created by Vishweshwaran on 11/09/22.
//

import Foundation

extension URL {
    func addQueryParamIfNeeded(_ queryParams: [String: Any]?) -> URL {
        guard let queryParams = queryParams,
              var urlComponents = URLComponents(string: absoluteString) else {
            return absoluteURL
        }
        let queryItems = queryParams.map { URLQueryItem(name: $0, value: "\($1)") }
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
}
