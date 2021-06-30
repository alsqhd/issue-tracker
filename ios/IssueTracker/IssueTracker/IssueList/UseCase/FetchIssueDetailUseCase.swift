//
//  FetchIssueDetailUseCase.swift
//  IssueTracker
//
//  Created by 지북 on 2021/06/23.
//

import Foundation
import Combine

protocol FetchIssueDetailUseCase {
    func excute(id: Int, completion: @escaping (Result<IssueDetail, NetworkError>) -> Void)

}

final class DefaultFetchIssueDetailUseCase: FetchIssueDetailUseCase {

    private var networkManager: NetworkManagerable
    private var cancelBag = Set<AnyCancellable>()
    
    init(networkManager: NetworkManagerable) {
        self.networkManager = networkManager
    }
    
    func excute(id: Int, completion: @escaping (Result<IssueDetail, NetworkError>) -> Void) {
        networkManager.get(path: "/issues/\(id)", type: IssueDetail.self)
            .receive(on: DispatchQueue.main)
            .sink { error in
                switch error {
                case .failure(let error): completion(.failure(error))
                case .finished: break
                }
            } receiveValue: { issueDetail in
                completion(.success(issueDetail))
            }.store(in: &cancelBag)
    }
}
