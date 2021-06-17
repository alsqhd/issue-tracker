//
//  NetworkComponents.swift
//  IssueTracker
//
//  Created by Lia on 2021/06/14.
//

import Foundation

enum NetworkError: Error {
    case BadURL
    case BadRequest
    case BadResponse
    case DecodingError(Error)
    case EncodingError(Error)
    case Unknown
    case Status(Int)
}

enum HTTPMethodType {
    static let get     = "GET"
    static let post    = "POST"
    static let put     = "PUT"
    static let patch   = "PATCH"
    static let delete  = "DELETE"
}

enum EndPoint {
    static let scheme = "https"
    static let host   = "issue-tracker-swagger.herokuapp.comERROR"
    
    static func url(path: String) -> URL? {
        var components = URLComponents()
        
        components.scheme = EndPoint.scheme
        components.host = EndPoint.host
        components.path = "\(path)"
        
        return components.url
    }
}
