//
//  LoginManager.swift
//  IssueTracker
//
//  Created by Lia on 2021/06/23.
//

import Foundation
import Combine

protocol OAuthManagerable {
    func requestCode(handler: @escaping (URL, String)->())
    func requestJWT(with code: URL)
    func fetchJWT() -> AnyPublisher<JWT, Never>
    func fetchError() -> AnyPublisher<NetworkError, Never>
}


struct JWT: Decodable {
    let jwt: String
}


final class DefaultOAuthManager: OAuthManagerable {
    
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

extension DefaultOAuthManager {
    
    func requestCode(handler: @escaping (URL, String)->()) {
        let url = LoginURL.url()!
        handler(url, LoginURL.callbackUrlScheme)
    }
    
    func requestJWT(with code: URL) {
        let code = abstractCode(with: code)
        
        networkManager.get(path: "/login/auth", code, type: JWT.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                switch error {
                case .failure(let error): self?.error = error
                case .finished: break
                }
            } receiveValue: { [weak self] jwt in
                self?.jwt = jwt
            }.store(in: &cancelBag)
    }
    
    private func abstractCode(with url: URL) -> String {
        if !url.absoluteString.starts(with: LoginURL.callbackUrlScheme) { return "" }
        guard let code = url.absoluteString.split(separator: "=").last.map({ String($0) }) else { return "" }
        return code
    }
    
    func fetchJWT() -> AnyPublisher<JWT, Never> {
        return $jwt.eraseToAnyPublisher()
    }
    
    func fetchError() -> AnyPublisher<NetworkError, Never> {
        return $error.eraseToAnyPublisher()
    }
    
}

