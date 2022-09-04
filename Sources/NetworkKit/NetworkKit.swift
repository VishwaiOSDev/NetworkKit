//
//  NetworkKit.swift
//  
//
//  Created by Vishweshwaran on 04/09/22.
//

import Foundation

public final class NetworkKit {
    
    public static let shared = NetworkKit()
    
    private init() { }
    
    public func request<T: Codable>(_ absoluteURL: String, type: T.Type) async throws -> T {
        guard let url = URL(string: absoluteURL) else  { throw NetworkingError.invaildURL }
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        try validateResponse(response)
        do {
            let decoder = JSONDecoder()
            let JSONResponse = try decoder.decode(T.self, from: data)
            return JSONResponse
        } catch {
            throw NetworkingError.failedToDecode(error: error)
        }
    }
    
    private func validateResponse(_ response: URLResponse) throws {
        guard let response = response as? HTTPURLResponse, (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invaildStatusCode(statusCode: statusCode)
        }
    }
}

extension NetworkKit {
    
    enum NetworkingError: Error {
        case invaildURL
        case invaildStatusCode(statusCode: Int)
        case failedToDecode(error: Error)
    }
}
