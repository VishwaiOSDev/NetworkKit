//
//  APIError.swift
//  
//
//  Created by Vishweshwaran on 11/09/22.
//

import Foundation

public struct APIError: Error {
    
    public let statusCode: Int
    public var data: Data?
    
    var networkError: NetworkError {
        switch statusCode {
        case 400: return .badInput(error: self)
        case 404: return .notFound(error: self)
        case 429: return .tooManyRequest(error: self)
        case 401...449: return .authError(error: self)
        case 500: return .internalServerError(error: self)
        case 501...599: return .badRequest(error: self)
        default: return .undefined(error: self)
        }
    }
}

public enum NetworkError: LocalizedError {
    
    /// Status code `400...499`
    case authError(error: APIError)
    case notFound(error: APIError)
    case tooManyRequest(error: APIError)
    case badInput(error: APIError)
    /// Status code `500...599`
    case badRequest(error: APIError)
    case undefined(error: APIError)
    case internalServerError(error: APIError)
    case noData
    case invalidHost
    
    public var errorDescription: String? {
        switch self {
        case .authError(let error): return "[\(error.statusCode)]: authentication error"
        case .notFound(let error): return "[\(error.statusCode)]: path which is requested not found"
        case .tooManyRequest(let error): return "[\(error.statusCode)]: too many request"
        case .badInput(let error): return "[\(error.statusCode)]: bad input"
        case .badRequest(let error): return "[\(error.statusCode)]: bad request"
        case .undefined(let error): return "[\(error.statusCode)]: undefined error"
        case .internalServerError(let error): return "[\(error.statusCode)]: internal server error"
        case .noData: return "No Data"
        case .invalidHost: return "Invaild Host"
        }
    }
}
