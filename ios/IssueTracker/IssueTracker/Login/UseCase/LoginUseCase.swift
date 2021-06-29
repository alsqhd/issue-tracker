//
//  LoginUseCase.swift
//  IssueTracker
//
//  Created by Lia on 2021/06/24.
//

import Foundation
import AuthenticationServices
import Combine

class LoginUseCase {
    
    private var oauthManager: OAuthManagerable
    
    @Published private var error: NetworkError
    private var cancelBag = Set<AnyCancellable>()
    
    init(loginManager: OAuthManagerable) {
        self.oauthManager = loginManager
        self.error = .Unknown
        bindJWT()
    }
    
}

extension LoginUseCase {
    
    func initAuthSession(completion: @escaping (ASWebAuthenticationSession) -> ()) {
        oauthManager.requestCode { url, callBackUrlScheme in
            completion(ASWebAuthenticationSession.init(url: url, callbackURLScheme: callBackUrlScheme) { [weak self] (callBack: URL?, error: Error?) in
                guard error == nil, let successURL = callBack else {
                    self?.error = NetworkError.OAuthError(error!)
                    return
                }
                self?.oauthManager.requestJWT(with: successURL)
            })
        }
    }
    
    private func bindJWT() {
        oauthManager.fetchJWT()
            .dropFirst(1)
            .receive(on: DispatchQueue.main)
            .sink { jwt in
                KeychainManager.save(jwt: jwt.jwt)
                LoginManager.shared.checkLogin()
            }.store(in: &cancelBag)
        
        oauthManager.fetchError()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.error = error
            }.store(in: &cancelBag)
    }
    
    func fetchError() -> AnyPublisher<NetworkError, Never> {
        return $error.eraseToAnyPublisher()
    }
    
}
