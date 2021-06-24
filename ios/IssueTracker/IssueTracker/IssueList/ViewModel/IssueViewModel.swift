//
//  IssueViewModel.swift
//  IssueTracker
//
//  Created by Lia on 2021/06/09.
//

import Foundation
import Combine

final class IssueViewModel {
    
    @Published private(set) var issues: [Issue]
    @Published private(set) var error: String
    
    private var fetchIssueListUseCase: FetchIssueListUseCase
    var filterUseCase: FilterUseCase
    private var cancelBag: AnyCancellable!

    init(_ fetchIssueListUseCase: FetchIssueListUseCase, _ filterUseCase: FilterUseCase) {
        self.fetchIssueListUseCase = fetchIssueListUseCase
        self.filterUseCase = filterUseCase
        self.issues = []
        self.error = ""
        loadIssues()
    }

}


extension IssueViewModel {
    
    private func loadIssues() {
        fetchIssueListUseCase.excute { [weak self] result in
            switch result {
            case .success(let issues):
                self?.issues = issues
            case .failure(let error):
                self?.handleError(error)
            }
        }
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
        case .Unknown:
            self.error = "잘 모르겠네요😅"
        }
    }
    
    func fetchIssueList() -> AnyPublisher<[Issue], Never> {
        return $issues.eraseToAnyPublisher()
    }
    
    func fetchError() -> AnyPublisher<String, Never> {
        return $error.eraseToAnyPublisher()
    }
    
}


extension IssueViewModel {

    func deleteIssue(at index: Int) {
        issues.remove(at: index)
    }
    
    func filter() {
        fetchIssueListUseCase.excute { [weak self] result in
            switch result {
            case .success(let issues):
                self?.issues = self?.filterUseCase.filterIssue(with: issues) ?? []
            case .failure(let error):
                self?.handleError(error)
            }
        }
    }
    
}
