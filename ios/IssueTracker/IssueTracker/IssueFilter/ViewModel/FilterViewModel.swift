//
//  FilterViewModel.swift
//  IssueTracker
//
//  Created by Lia on 2021/06/20.
//

import Foundation
import Combine

final class FilterViewModel {
    
    @Published private var identifierFilter: [Parent]
    @Published private var error: String
    
    private var fetchFilterUseCase: FetchFilterUseCase
    private var filterUseCase: FilterUseCase
    private var isIssueListDelegate: Bool
    
    init(_ fetchIssueListUseCase: FetchFilterUseCase, _ filterUseCase: FilterUseCase, _ isIssueListDelegate: Bool) {
        self.fetchFilterUseCase = fetchIssueListUseCase
        self.filterUseCase = filterUseCase
        self.isIssueListDelegate = isIssueListDelegate
        self.identifierFilter = []
        self.error = ""
        loadFilters()
    }

}


extension FilterViewModel {
    
    private func loadFilters() {
        fetchFilterUseCase.excute { [weak self] result in
            switch result {
            case .success(let filterList):
                self?.loadFilterList(with: filterList)
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
        case .OAuthError(let error):
            self.error = "\(error.localizedDescription)"
        case .Unknown:
            self.error = "잘 모르겠네요😅"
        }
    }
    
    private func loadFilterList(with filterList: FilterList) {
        
        if isIssueListDelegate {
            identifierFilter = [
                Parent(title: "상태", isStatus: true, children: Status.allCases.map { Child(title: $0.rawValue, id: $0.hashValue)}),
                Parent(title: "작성자", isStatus: false, children: filterList.users.map{ Child(title: $0.name, id: $0.id)}),
                Parent(title: "레이블", isStatus: false, children: filterList.labels.map{ Child(title:  $0.name, id: $0.id)}),
                Parent(title: "마일스톤", isStatus: false, children: filterList.mileStone.map{ Child(title:  $0.name, id: $0.id)})
            ]
        } else {
            identifierFilter = [
                Parent(title: "레이블", isStatus: false, children: filterList.labels.map{ Child(title:  $0.name, id: $0.id)}),
                Parent(title: "마일스톤", isStatus: false, children: filterList.mileStone.map{ Child(title:  $0.name, id: $0.id)}),
                Parent(title: "담당자", isStatus: false, children: filterList.users.map{ Child(title: $0.name, id: $0.id)})
            ]
        }
    }
    
    func fetchFilterList() -> AnyPublisher<[Parent], Never> {
        return $identifierFilter.eraseToAnyPublisher()
    }
    
    func fetchError() -> AnyPublisher<String, Never> {
        return $error.eraseToAnyPublisher()
    }
    
}

//MARK:- Selection Logic

extension FilterViewModel {
    
    func select(index: IndexPath) {
        filterUseCase.select(index: index)
    }
    
    func selectedIndexPaths() -> [IndexPath] {
        return filterUseCase.selectedIndexPaths()
    }
    
    func deselect(index: IndexPath) {
        filterUseCase.deselect(index: index)
    }
    
    func deselectAll() {
        filterUseCase.deselectAll()
    }
    
    func saveIndexPath() {
        filterUseCase.saveIndexPaths()
    }
    
    func getSavedIndexPath() -> [IndexPath] {
        return filterUseCase.savedIndex
    }
    
    func resetSelectedIndexPath() {
        filterUseCase.resetSelectedIndexPaths()
    }
    
    func setFilter() {
        filterUseCase.setFilter(dataSource: identifierFilter)
    }
}
