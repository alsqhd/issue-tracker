//
//  LoginViewController.swift
//  IssueTracker
//
//  Created by Lia on 2021/06/23.
//

import UIKit
import Combine
import AuthenticationServices

extension LoginViewController: ViewControllerIdentifierable {
    
    static func create(_ viewModel: LoginViewModel) -> LoginViewController {
        guard let vc = storyboard.instantiateViewController(identifier: storyboardID) as? LoginViewController else {
            return LoginViewController()
        }
        vc.viewModel = viewModel
        return vc
    }
    
}


class LoginViewController: UIViewController {
    
    private var webAuthSession: ASWebAuthenticationSession?
    private var viewModel: LoginViewModel!
    private var cancelBag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebAuthSession()
        bind()
    }
    
}


extension LoginViewController: Alertable {
    
    private func bind() {
        viewModel.fetchError()
            .dropFirst(3)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.showAlert(message: error)
                self?.webAuthSession = nil
            }.store(in: &cancelBag)
    }
    
}


extension LoginViewController: ASWebAuthenticationPresentationContextProviding {
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return self.view.window ?? ASPresentationAnchor()
    }
    
    private func configureWebAuthSession() {
        viewModel.initAuthSession { [weak self] authenticationSession in
            self?.webAuthSession = authenticationSession
        }
        webAuthSession?.presentationContextProvider = self
    }

    @IBAction func githubLoginButtonTouched(_ sender: UIButton) {
        configureWebAuthSession()
        webAuthSession?.start()
    }
    
}
