//
//  IssueViewModel.swift
//  IssueTracker
//
//  Created by Lia on 2021/06/09.
//

import Foundation

class IssueViewModel {
    
    private(set) var issues: [Issue]
    private(set) var error: String?
    
    private var fetchIssueListUseCase: FetchIssueListUseCase

    init(_ fetchIssueListUseCase: FetchIssueListUseCase) {
        self.fetchIssueListUseCase = fetchIssueListUseCase
        self.issues = []
        load()
    }
    
    private func load() {
        fetchIssueListUseCase.excute { result in
            switch result {
            case .success(let issues):
                self.issues = issues
            case .failure(let error):
                self.errorHandle(error: error)
            }
        }
    }
    
    private func errorHandle(error: NetworkError) {
        
    }
}


extension IssueViewModel {

    func deleteIssue(at index: Int) {
        issues.remove(at: index)
    }
    
}
