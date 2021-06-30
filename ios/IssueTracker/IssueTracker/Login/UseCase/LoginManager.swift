//
//  LoginManager.swift
//  IssueTracker
//
//  Created by Lia on 2021/06/28.
//

import Foundation
import Combine

class LoginManager {
    
    static let shared = LoginManager()
    
    private init() {}

    @Published private var isLoggedin: Bool = (Keychain.load(key: "jwt") != nil)

}


extension LoginManager {
    
    func checkLogin(){
        isLoggedin = (Keychain.load(key: "jwt") != nil)
    }
    
    func fetchIsLoggedin() -> AnyPublisher<Bool, Never> {
        return $isLoggedin.eraseToAnyPublisher()
    }
    
}
