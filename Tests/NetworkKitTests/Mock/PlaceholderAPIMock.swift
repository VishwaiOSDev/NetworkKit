//
//  PlaceholderAPIMock.swift
//  
//
//  Created by Vishweshwaran on 23/09/22.
//

import Foundation
@testable import NetworkKit

enum PlaceholderAPIMock {
    case post, comments, albums, photos, todos, users
}

extension PlaceholderAPIMock: NetworkRequestable {
    
    var host: String { "jsonplaceholder.typicode.com" }
    
    var path: String {
        switch self {
        case .post:
            return "/posts"
        case .comments:
            return "/comments"
        case .albums:
            return "/albums"
        case .photos:
            return "/photos"
        case .todos:
            return "/todos"
        case .users:
            return "/users"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .post, .comments, .albums, .photos, .todos, .users:
            return .get
        }
    }
    
    var queryParameter: [String : AnyHashable]? {
        return nil
    }
}
 
