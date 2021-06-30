//
//  MyAccountViewModel.swift
//  IssueTracker
//
//  Created by Lia on 2021/06/25.
//

import UIKit

class MyAccountViewModel {
    
    private(set) var user: User!
    private var loginUseCase: LoginUseCase
    
    init(loginUseCase: LoginUseCase) {
        self.user = KeychainManager.loadUser()
        self.loginUseCase = loginUseCase
    }
    
    // Dumba merge 후 수정
    private func convert(imageUrlString: String) -> UIImage {
        guard let url = URL(string: imageUrlString) else { return UIImage() }
        let data = try? Data(contentsOf: url)
        return UIImage(data: data!) ?? UIImage()
    }
    
    func logout() {
        loginUseCase.logout()
    }
    
}
