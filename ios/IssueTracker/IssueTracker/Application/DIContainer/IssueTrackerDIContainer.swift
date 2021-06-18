//
//  IssueTrackerDIContainer.swift
//  IssueTracker
//
//  Created by 지북 on 2021/06/15.
//

import UIKit

class IssueTrackerDIContainer: SceneFlowCoordinatorDependencies {
    private func makeFetchIssueListUseCase() -> FetchIssueListUseCase {
        return MockFetchIssueListUseCase()
    }
    private func makeIssueListViewModel() -> IssueViewModel {
        return IssueViewModel(makeFetchIssueListUseCase())
    }
    
    private func makeIssueListViewController(_ action: IssueListViewControllerAction) -> IssueListViewController {
        return IssueListViewController.create(makeIssueListViewModel(), action)
    }
    
    func makeIssueListNavigationController(_ action: IssueListViewControllerAction) -> UINavigationController {
        return UINavigationController(rootViewController: makeIssueListViewController(action))
    }
    
    func makeIssueListTabBarController(_ viewControllers: [UIViewController]) -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = viewControllers
        return tabBarController
    }
    
    func makeSceneFlowCoordinator(_ rootViewController: UINavigationController) -> SceneFlowCoordinator {
        return SceneFlowCoordinator(rootViewController, self)
    }
}

extension IssueTrackerDIContainer {
    private func makePostNewIssueUseCase() -> PostNewIssueUseCase {
        return DefaultPostNewIssueUseCase()
    }
    
    private func makeNewIssueViewModel() -> NewIssueViewModel {
        return NewIssueViewModel(makePostNewIssueUseCase())
    }
    
    private func makeMarkdownViewController(_ viewModel: NewIssueViewModel) -> MarkdownViewController {
        return MarkdownViewController.create(viewModel)
    }
    
    private func makePreviewViewController(_ viewModel: NewIssueViewModel) -> PreviewViewController {
        return PreviewViewController.create(viewModel)
    }
    
    func makeNewIssueViewController() -> NewIssueViewController {
        let viewModel = makeNewIssueViewModel()
        
        return NewIssueViewController.create(viewModel, makeMarkdownViewController(viewModel), makePreviewViewController(viewModel))
    }
}
