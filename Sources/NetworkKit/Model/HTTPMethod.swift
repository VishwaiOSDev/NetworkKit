//
//  HTTPMethod.swift
//  
//
//  Created by Vishweshwaran on 07/09/22.
//

import Foundation

public struct HTTPMethod: RawRepresentable {

    public static let delete = HTTPMethod(rawValue: "DELETE")
    public static let get = HTTPMethod(rawValue: "GET")
    public static let post = HTTPMethod(rawValue: "POST")
    public static let put = HTTPMethod(rawValue: "PUT")
    public static let patch = HTTPMethod(rawValue: "PATCH")

    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
