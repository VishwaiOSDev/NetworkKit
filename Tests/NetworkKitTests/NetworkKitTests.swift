//
//  NetworkKitTests.swift
//  NetworkKitTests
//
//  Created by Vishweshwaran on 04/09/22.
//

import XCTest
import LogKit
@testable import NetworkKit

class NetworkKitTests: XCTestCase {
    
    var networkKit = NetworkKit.shared
    
    override func setUp() { }
    
    override func tearDown() { }
    
    func testCheckEndpointConfigurationForPlaceholderAPI() {
        let placeholderApiMock = PlaceholderAPIMock.post
        
        XCTAssertEqual(placeholderApiMock.host, "jsonplaceholder.typicode.com")
        XCTAssertEqual(placeholderApiMock.httpMethod, .get)
        XCTAssertEqual(placeholderApiMock.path, "/posts")
        XCTAssertEqual(placeholderApiMock.queryParameter, nil)
        XCTAssertEqual(try placeholderApiMock.url, URL(string: "https://jsonplaceholder.typicode.com/posts"))
    }
}

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

final class NetworkingTest: NetworkKitTests {
    
    func testNetworkingHittingAPISuccess() async {
        let placeholderAPI = PlaceholderAPIMock.post
        
        do {
            let response = try await networkKit.requestCodable(placeholderAPI, type: [Post].self)
            
            XCTAssertNotNil(response)
            XCTAssertEqual(response.count, 100)
        } catch {
            Log.error(error)
        }
    }
    
    func testNetworkingShouldThrowError() async {
        let expectation = self.expectation(description: "failure without retry")
        
        /// Given API has an invaild path
        let commentsAPI = PlaceholderAPIMock.comments
        
        do {
            let response = try await networkKit.requestCodable(commentsAPI, type: [Post].self)
            Log.verbose(response)
        } catch {
            Log.error(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
