//
//  NetworkKit.swift
//  
//
//  Created by Vishweshwaran on 04/09/22.
//

import Foundation
import LogKit

public final class NetworkKit {
    
    public static let shared = NetworkKit()
    
    private init() { }
    
    public func requestJSON<T: Codable>(_ requestable: NetworkRequestable, type: T.Type) async throws -> T {
        return try await processRequest(for: requestable, to: type)
    }
}

extension NetworkKit {
    
    fileprivate func processRequest<T: Codable>(for request: NetworkRequestable, to type: T.Type) async throws -> T  {
        let url = request.url.addQueryParamIfNeeded(request.queryParameter)
        let request = buildRequest(from: url, methodType: request.httpMethod)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            try validateResponse(response)
            let JSONResponse = try JSONDecoder().decode(T.self, from: data)
            return JSONResponse
        } catch {
            throw URLError(.badURL)
//            throw NetworkingError.failedToDecode(error: error)
        }
    }
}

extension NetworkKit {
    
    fileprivate func validateResponse(_ response: URLResponse) throws {
        guard let response = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }
        guard (200...299) ~= response.statusCode else {
            throw URLError(.badURL)
//            throw NetworkingError.invaildStatusCode(statusCode: response.statusCode)
        }
    }
    
    fileprivate func buildRequest(from url: URL, methodType: HTTPMethod) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = methodType.rawValue
        return request
    }
}
