//
//  NetworkKitTests.swift
//  NetworkKitTests
//
//  Created by Vishweshwaran on 04/09/22.
//

import XCTest
import LogKit
@testable import NetworkKit

final class NetworkKitTests: XCTestCase {
    
    override func setUpWithError() throws { }
    
    override func tearDownWithError() throws { }
    
    func testCheckEndpointConfiguration() {
        let apiMock = APIMock.details
        
        XCTAssertEqual(apiMock.host, "api.loadify.app")
        XCTAssertEqual(apiMock.httpMethod, .get)
        XCTAssertEqual(apiMock.path, "/api/details")
        XCTAssertEqual(apiMock.queryParameter, nil)
        XCTAssertEqual(try apiMock.url, URL(string: "https://api.loadify.app/api/details"))
    }
    
    func testCheckEndpointConfigurationWithQueryParameters() {
        let apiMock = APIMock.download
        
        XCTAssertEqual(apiMock.host, "api.loadify.app")
        XCTAssertEqual(apiMock.httpMethod, .get)
        XCTAssertEqual(apiMock.path, "/api/download")
        XCTAssertEqual(apiMock.queryParameter, ["url": "https://www.youtube.com/watch?v=Y9bDQ1P8lZY"])
        XCTAssertEqual(try apiMock.url, URL(string: "https://api.loadify.app/api/download?url=https://www.youtube.com/watch?v%3DY9bDQ1P8lZY"))
    }
    
    func testCheckEndpointConfigurationForPlaceholderAPI() {
        let placeholderApiMock = PlaceholderAPIMock.post
        
        XCTAssertEqual(placeholderApiMock.host, "jsonplaceholder.typicode.com")
        XCTAssertEqual(placeholderApiMock.httpMethod, .get)
        XCTAssertEqual(placeholderApiMock.path, "/posts")
        XCTAssertEqual(placeholderApiMock.queryParameter, nil)
        XCTAssertEqual(try placeholderApiMock.url, URL(string: "https://jsonplaceholder.typicode.com/posts"))
    }
}
