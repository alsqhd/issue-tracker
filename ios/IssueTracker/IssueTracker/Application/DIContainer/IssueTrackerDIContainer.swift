//
//  IssueTrackerDIContainer.swift
//  IssueTracker
//
//  Created by 지북 on 2021/06/15.
//

import UIKit

class IssueTrackerDIContainer: SceneFlowCoordinatorDependencies {
    
    private let networkManager = NetworkManager()
    
    private func makeFetchIssueListUseCase() -> FetchIssueListUseCase {
        return DefaultFetchIssueListUseCase(networkManager: networkManager)
    }
    
    private func makeIssueListViewModel() -> IssueViewModel {
        return IssueViewModel(makeFetchIssueListUseCase())
    }
    
    private func makeIssueListViewController() -> IssueListViewController {
        return IssueListViewController.create(makeIssueListViewModel())
    }
    
    private func makeIssueListNavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: makeIssueListViewController())
    }
    
    func makeIssueListTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [makeIssueListNavigationController()]
        return tabBarController
    }
    
    func makeSceneFlowCoordinator(_ rootViewController: UINavigationController) -> SceneFlowCoordinator {
        return SceneFlowCoordinator(rootViewController, self)
    }
    
}
