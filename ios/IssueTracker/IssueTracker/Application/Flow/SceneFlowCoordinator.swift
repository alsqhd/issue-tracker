//
//  SceneFlowCoordinator.swift
//  IssueTracker
//
//  Created by 지북 on 2021/06/15.
//

import UIKit
import Combine

protocol SceneFlowCoordinatorDependencies {
    func makeIssueListTabBarController(_ viewControllers: [UIViewController]) -> UITabBarController
    func makeIssueListNavigationController(_ action: IssueListViewControllerAction) -> UINavigationController
    func makeNewIssueViewController(_ action: NewIssueViewControllerAction) -> NewIssueViewController
    func makeIssueDetailViewController(_ issue: IssueDetail) -> IssueDetailViewController
    func makeIssueFilterViewController(_ isIssueListDelegate: Bool) -> IssueFilterViewController
    func makeLoginViewController() -> LoginViewController
    func makeMyAccountViewController() -> MyAccountViewController
}


class SceneFlowCoordinator {
    
    private weak var rootVC: UINavigationController?
    private var dependencies: SceneFlowCoordinatorDependencies
    private var issueListViewController: UINavigationController?
    private var cancelBag = Set<AnyCancellable>()
    
    init(_ rootViewController: UINavigationController, _ dependencies: SceneFlowCoordinatorDependencies) {
        self.rootVC = rootViewController
        self.dependencies = dependencies
    }

}


extension SceneFlowCoordinator {
    
    func bindLogin() {
        LoginManager.shared.fetchIsLoggedin()
            .receive(on: DispatchQueue.main)
            .sink { isLoggedin in
                if isLoggedin {
                    self.pushTabBarVC()
                } else {
                    self.pushLoginVC()
                }
            }.store(in: &cancelBag)
    }
    
    private func pushLoginVC() {
        let vc = dependencies.makeLoginViewController()

        rootVC?.setNavigationBarHidden(true, animated: false)
        rootVC?.pushViewController(vc, animated: true)
    }
    
    private func pushTabBarVC() {
        let issueListVCAction = IssueListViewControllerAction(showNewIssueView: showNewIssueView, showIssueDetailView: showIssueDetailView(_:), showFilterView: showFilterView(_:_:))
        let issueListViewController = dependencies.makeIssueListNavigationController(issueListVCAction)
        self.issueListViewController = issueListViewController
        let myAccountViewController = dependencies.makeMyAccountViewController()
       
        let viewControllers = [issueListViewController, myAccountViewController]
        let tabBarController = dependencies.makeIssueListTabBarController(viewControllers)

        rootVC?.setNavigationBarHidden(true, animated: false)
        rootVC?.pushViewController(tabBarController, animated: true)
    }
    
}


extension SceneFlowCoordinator {
    
    func showNewIssueView() {
        guard let issueListViewController = issueListViewController else { return }
        let action = NewIssueViewControllerAction(showFilterView: showFilterView(_:_:), showIssueDetailView: showIssueDetailView(_:))
        let vc = dependencies.makeNewIssueViewController(action)
        issueListViewController.pushViewController(vc, animated: true)
    }
    
    func showIssueDetailView(_ issue: IssueDetail) {
        guard let issueListViewController = issueListViewController else { return }
        let vc = dependencies.makeIssueDetailViewController(issue)
        vc.hidesBottomBarWhenPushed = true
        issueListViewController.pushViewController(vc, animated: true)
    }
    
    func showIssueListView() {
        issueListViewController?.popToRootViewController(animated: true)
    }
    
    func showFilterView(_ isIssueListDelegate: Bool, _ delegate: IssueFilterViewControllerDelegate) {
        guard let issueListViewController = issueListViewController else { return }
        let vc = dependencies.makeIssueFilterViewController(isIssueListDelegate)
        vc.delegate = delegate
        issueListViewController.present(vc, animated: true, completion: nil)
    }
    
}
