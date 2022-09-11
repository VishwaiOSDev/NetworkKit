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
    
    public func request<T: Codable>(_ requestable: NetworkRequestable, type: T.Type) async throws -> T {
        let url = requestable.url.addQueryParamIfNeeded(requestable.queryParameter)
        let request = buildRequest(from: url, methodType: requestable.httpMethod)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            try validateResponse(response)
            let JSONResponse = try JSONDecoder().decode(T.self, from: data)
            return JSONResponse
        } catch {
            throw NetworkingError.failedToDecode(error: error)
        }
    }
    
    private func validateResponse(_ response: URLResponse) throws {
        guard let response = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }
        guard (200...300) ~= response.statusCode else {
            throw NetworkingError.invaildStatusCode(statusCode: response.statusCode)
        }
    }
}

private extension NetworkKit {
    func buildRequest(from url: URL, methodType: HTTPMethod) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = methodType.rawValue
        return request
    }
}
