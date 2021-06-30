//
//  NewIssueViewModel.swift
//  IssueTracker
//
//  Created by 지북 on 2021/06/18.
//

import Foundation
import Combine


final class NewIssueViewModel {
    
    enum FilteringSection: Int, CaseIterable {
        case label
        case milestone
        case assignees
    }
    
    @Published private(set) var error: String
    @Published private(set) var filteringSections: [[Child?]]
    @Published private(set) var imagePath: String
    @Published private(set) var isSaveable: Bool
    
    private var postNewIssueUseCase: PostNewIssueUseCase
    private var uploadImageUseCase: UploadImageUseCase
    private var filterUseCase: NewIssueFilterUseCase
    
    var bodyText: String?
    
    init(_ postNewIssueUseCase: PostNewIssueUseCase, _ postImageFileUseCase: UploadImageUseCase, _ filterUseCase: NewIssueFilterUseCase) {
        self.postNewIssueUseCase = postNewIssueUseCase
        self.uploadImageUseCase = postImageFileUseCase
        self.error = ""
        self.imagePath = ""
        self.filteringSections = []
        self.isSaveable = false
        self.filterUseCase = filterUseCase
        
        setFilteringSections()
    }
    
}

//MARK: - Filtering

extension NewIssueViewModel {
    
    private func setFilteringSections() {
        FilteringSection.allCases.forEach { _ in
            filteringSections.append([])
        }
    }
    
    func filter() {
        filteringSections = filterUseCase.filteringSection()
    }
    
    func resetSavedIndex() {
        filterUseCase.resetSavedIndex()
    }
    
}

//MARK: Image Upload

extension NewIssueViewModel {
    
    func requestUploadImage(_ data: Data?) {
        uploadImageUseCase.excute(data: data) { [weak self] result in
            switch result {
            case .success(let imageFile):
                self?.imagePath = imageFile.markdownImagePath()
            case .failure(let error):
                self?.handleError(error)
            }
        }
    }
    
    func fetchImagePath() -> AnyPublisher<String, Never> {
        return $imagePath.eraseToAnyPublisher()
    }
    
}

//MARK: - New Issue Save n Post

extension NewIssueViewModel {
    
    func fetchIsSavealbe() -> AnyPublisher<Bool, Never> {
        return $isSaveable.eraseToAnyPublisher()
    }
    
    func checkSaveable(_ title: String, _ comments: String) {
        if !title.isEmpty && !comments.isEmpty {
            isSaveable = true
        } else {
            isSaveable = false
        }
    }
    
    func saveNewIssue(_ title: String, _ comments: String, completion: @escaping (IssueDetail) -> Void ) {
        let assigneeIds: [Int]? = filteringSections[FilteringSection.assignees.rawValue].map { $0?.id }.compactMap { $0 }
        let labelIds = filteringSections[FilteringSection.label.rawValue].map { $0?.id }.compactMap { $0 }
        let milestoneIds = filteringSections[FilteringSection.milestone.rawValue].map { $0?.id }.compactMap { $0 }
        var milestoneId: Int? = nil
        
        if !milestoneIds.isEmpty {
            milestoneId = milestoneIds[0]
        }
        
        postNewIssueUseCase.execute(title: title,
                                    mainComments: comments,
                                    authorId: 0,
                                    assigneeIds: assigneeIds,
                                    labelIds: labelIds,
                                    milestoneId: milestoneId)
        { [weak self] result in
            switch result {
            case .success(let issueDetail):
                completion(issueDetail)
            case .failure(let error):
                self?.handleError(error)
            }
        }
    }
    
}

//MARK: - Error

extension NewIssueViewModel {
    
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
            self.error = error.localizedDescription
        case .Unknown:
            self.error = "잘 모르겠네요😅"
        }
    }
    
    func fetchError() -> AnyPublisher<String, Never> {
        return $error.eraseToAnyPublisher()
    }
    
}
