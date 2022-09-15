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
    
    func testURLConstruction() {
        do {
            let url = try NetworkKit.shared.buildURL(for: APIMock.download)
            
            XCTAssertEqual(url, URL(string: "https://api.loadify.app/api/download")!)
        } catch {
            Log.error(error)
        }
    }
}

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
    
    var queryParameter: [String : Any]? {
        return nil
    }
}
