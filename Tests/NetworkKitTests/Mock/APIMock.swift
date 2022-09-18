//
//  APIMock.swift
//  
//
//  Created by Vishweshwaran on 16/09/22.
//

import Foundation
@testable import NetworkKit

enum APIMock {
    case details, download
}

extension APIMock: NetworkRequestable {
    
    var host: String {
        return "api.loadify.app"
    }
    
    var path: String {
        switch self {
        case .details:
            return "/api/details"
        case .download:
            return "/api/download"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .details, .download:
            return HTTPMethod.get
        }
    }
    
    var queryParameter: [String : AnyHashable]? {
        switch self {
        case .details:
            return nil
        case .download:
            return ["url": "https://www.youtube.com/watch?v=Y9bDQ1P8lZY"]
        }
    }
}
