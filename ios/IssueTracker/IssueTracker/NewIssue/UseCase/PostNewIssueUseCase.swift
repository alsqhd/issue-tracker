//
//  PostNewIssueUseCase.swift
//  IssueTracker
//
//  Created by 지북 on 2021/06/18.
//

import Foundation
import Combine

protocol PostNewIssueUseCase {
    func execute(title: String, mainComments:String, authorId: Int, assigneeIds: [Int]?, labelIds: [Int]?, milestoneId: Int?, completion: @escaping (Result<IssueDetail, NetworkError>) -> Void )
}

final class DefaultPostNewIssueUseCase: PostNewIssueUseCase {
    
    private var networkManager: NetworkManagerable
    private var cancelBag = Set<AnyCancellable>()
    
    init(_ networkManager: NetworkManagerable) {
        self.networkManager = networkManager
    }
    
    func execute(title: String, mainComments:String, authorId: Int, assigneeIds: [Int]?, labelIds: [Int]?, milestoneId: Int?, completion: @escaping (Result<IssueDetail, NetworkError>) -> Void ) {
        let newIssue = NewIssue.init(title: title, mainCommentContents: mainComments, authorId: authorId, assigneeIds: assigneeIds, labelIds: labelIds, milestoneId: milestoneId)
        networkManager.post(path: "/issues", data: newIssue, result: IssueDetail.self)
            .receive(on: DispatchQueue.main)
            .sink { error in
                switch error {
                case .failure(let error): completion(.failure(error))
                case .finished: break
                }
            } receiveValue: { issueDetail in
                completion(.success(issueDetail))
            }
            .store(in: &cancelBag)

    }
    
}
