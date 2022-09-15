//
//  NetworkKit.swift
//  
//
//  Created by Vishweshwaran on 04/09/22.
//

import Foundation
import LogKit

protocol Networkable {
    func requestJSON<T: Codable, Network: NetworkRequestable>(_ requestable: Network, type: T.Type) async throws -> T
    func requestData<Network: NetworkRequestable>(_ requestable: Network) async throws -> Data
}

public final class NetworkKit: Networkable {
    
    public static let shared = NetworkKit()
    
    private init() { }
    
    public func requestJSON<T: Codable, Network: NetworkRequestable>(_ requestable: Network, type: T.Type) async throws -> T {
        return try await processRequest(for: requestable, to: type)
    }
    
    public func requestData<Network: NetworkRequestable>(_ requestable: Network) async throws -> Data {
        return try await processRequest(for: requestable)
    }
}

extension NetworkKit {
    
    fileprivate func processRequest<T: Codable, Network: NetworkRequestable>(for request: Network, to type: T.Type) async throws -> T  {
        let url = try buildURL(for: request)
        let URLRequest = buildRequest(from: url, methodType: request.httpMethod)
        let data = try await performNetworkRequest(URLRequest)
        return decode(data, type: T.self)
    }
    
    fileprivate func processRequest(for request: NetworkRequestable) async throws -> Data {
        let url = try buildURL(for: request)
        let URLRequest = buildRequest(from: url, methodType: request.httpMethod)
        return try await performNetworkRequest(URLRequest)
    }
}

extension NetworkKit {
    
    internal func buildURL<Network: NetworkRequestable>(for requestable: Network) throws -> URL {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = requestable.host
        urlComponent.path = requestable.path
        guard let url = urlComponent.url else { throw URLError(.badURL) }
        return url.addQueryParamIfNeeded(requestable.queryParameter)
    }
    
    fileprivate func buildRequest(from url: URL, methodType: HTTPMethod) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = methodType.rawValue
        return request
    }
    
    fileprivate func performNetworkRequest(_ request: URLRequest) async throws -> Data {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.noData }
            guard (200...299) ~= httpResponse.statusCode else {
                let error = APIError(statusCode: httpResponse.statusCode, data: data)
                throw error.networkError
            }
            return data
        } catch {
            Log.error(error.localizedDescription)
            guard let error = error as? NetworkError else { throw NetworkError.invalidHost }
            throw error
        }
    }
    
    fileprivate func decode<T>(_ data: Data, type: T.Type) -> T where T: Codable {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            Log.error(error)
            preconditionFailure("Failed to decode the data")
        }
    }
}
