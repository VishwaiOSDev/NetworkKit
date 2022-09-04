//
//  NetworkKit+Extension.swift
//  
//
//  Created by Vishweshwaran on 04/09/22.
//

import Foundation

extension NetworkKit {
    enum NetworkingError: Error {
        case invaildURL
        case invaildStatusCode(statusCode: Int)
        case failedToDecode(error: Error)
    }
}

public extension NetworkKit {
    enum MethodType {
        case GET
        case POST
    }
}
