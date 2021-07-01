//
//  MyAccountViewModel.swift
//  IssueTracker
//
//  Created by Lia on 2021/06/25.
//

import Foundation

class MyAccountViewModel {
    
    private(set) var user: User!
    private var loginUseCase: LoginUseCase
    
    init(loginUseCase: LoginUseCase) {
        self.user = KeychainManager.loadUser()
        self.loginUseCase = loginUseCase
    }
    
    func logout() {
        loginUseCase.logout()
    }
    
}
