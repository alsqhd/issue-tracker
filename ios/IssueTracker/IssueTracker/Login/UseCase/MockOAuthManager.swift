//
//  MockOAuthManager.swift
//  IssueTracker
//
//  Created by Lia on 2021/06/28.
//

import Foundation
import Combine

final class MockOAuthManager: OAuthManagerable {
    
    @Published private var jwt: JWT
    @Published private var error: NetworkError
    
    private var networkManager: NetworkManagerable!
    private var cancelBag = Set<AnyCancellable>()
    
    init(networkManager: NetworkManagerable) {
        self.networkManager = networkManager
        self.jwt = JWT(jwt: "")
        self.error = .Unknown
    }
    
}

extension MockOAuthManager {
    
    func requestCode(handler: @escaping (URL, String)->()) {
        let url = LoginURL.url()!
        handler(url, LoginURL.callbackUrlScheme)
    }
    
    func requestJWT(with code: URL) {
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NzM2NTA5OTQsInBvc3Nlc3Npb25DYW1wIjpudWxsLCJnaXRodWJpZCI6IkxpYTMxNiIsImRpc3BsYXlOYW1lIjoiTGlhIiwiZW1haWwiOm51bGwsInByb2ZpbGVQaG90byI6Imh0dHBzOi8vYXZhdGFyczEuZ2l0aHVidXNlcmNvbnRlbnQuY29tL3UvNzM2NTA5OTQ_dj00Iiwicm9sZSI6bnVsbCwiY2xhc3MiOiJtb2JpbGUiLCJpYXQiOjE2MjQ4NDQ3MzAsImV4cCI6MTYyNzQzNjczMCwiaXNzIjoiY29kZXNxdWFkLmtyIiwic3ViIjoiVXNlckluZm8ifQ.CC5UwKjE3Eoek52D_fdjzQVPhh55UHJCvDbYyuFM6-Q"
        jwt = JWT(jwt: token)
    }
    
    func fetchJWT() -> AnyPublisher<JWT, Never> {
        return $jwt.eraseToAnyPublisher()
    }
    
    func fetchError() -> AnyPublisher<NetworkError, Never> {
        return $error.eraseToAnyPublisher()
    }
    
}

