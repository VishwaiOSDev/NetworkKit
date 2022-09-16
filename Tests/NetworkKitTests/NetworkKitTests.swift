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
    
    func testURLConstruction() {
        do {
            let url = try NetworkKit.shared.buildURL(for: APIMock.download)
            
            XCTAssertEqual(url, URL(string: "https://api.loadify.app/api/download")!)
        } catch {
            Log.error(error)
        }
    }
}
