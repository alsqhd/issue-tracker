//
//  LoginURL.swift
//  IssueTracker
//
//  Created by Lia on 2021/06/24.
//

import Foundation

enum LoginURL {
    static let callbackUrlScheme = "issuetracker"
    static let scheme = "https"
    static let host = "github.com"
    static let path = "/login/oauth/authorize"
    static let redirectURI = "issueTracker://login"
    static let scope = "user"
}

extension LoginURL {
    
    static func url() -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = [
            URLQueryItem(name: "client_id", value: getClientID()),
            URLQueryItem(name: "redirect_uri", value: redirectURI),
            URLQueryItem(name: "scope", value: scope)
        ]
        return components.url
    }

    static func getClientID() -> String {
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist") else { return "" }
        let plist = NSDictionary(contentsOfFile: path)
        guard let key = plist?.object(forKey: "ClientID") as? String else { return "" }
        return key
    }

}
