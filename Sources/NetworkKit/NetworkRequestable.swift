//
//  NetworkRequestable.swift
//  
//
//  Created by Vishweshwaran on 07/09/22.
//

import Foundation

public protocol NetworkRequestable {
    var host: String { get } 
    var url: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var queryParameter: [String: Any]? { get }
}
