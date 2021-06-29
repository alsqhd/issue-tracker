//
//  LoginViewModel.swift
//  IssueTracker
//
//  Created by Lia on 2021/06/24.
//

import Foundation
import AuthenticationServices
import Combine

final class LoginViewModel {
    
    @Published private var error: String
    
    private var loginUseCase: LoginUseCase
    private var cancelBag = Set<AnyCancellable>()

    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
        self.error = ""
        bindError()
    }

}


extension LoginViewModel {
    
    func initAuthSession(completion: @escaping (ASWebAuthenticationSession) -> ()) {
        loginUseCase.initAuthSession(completion: completion)
    }
    
}


extension LoginViewModel {
    
    func fetchError() -> AnyPublisher<String, Never> {
        return $error.eraseToAnyPublisher()
    }
    
    private func bindError() {
        loginUseCase.fetchError()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.handleError(error)
            }.store(in: &cancelBag)
    }
    
    private func handleError(_ error: NetworkError) {
        switch error {
        case .BadURL:
            self.error = "잘못된 URL입니다"
        case .BadRequest:
            self.error = "잘못된 요청입니다.\nURL을 다시 확인해보세요"
        case .BadResponse:
            self.error = "잘못된 response입니다."
        case .Status(let statusCode):
            self.error = "\(statusCode) 에러!"
        case .DecodingError:
            self.error = "디코딩 에러"
        case .EncodingError:
            self.error = "인코딩 에러"
        case .OAuthError(let error):
            self.error = "\(error.localizedDescription)"
        case .Unknown:
            self.error = "잘 모르겠네요😅"
        }
    }
    
}
