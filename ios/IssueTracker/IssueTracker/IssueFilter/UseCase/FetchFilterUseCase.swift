//
//  FilterUseCase.swift
//  IssueTracker
//
//  Created by Lia on 2021/06/20.
//

import Foundation
import Combine

protocol FetchFilterUseCase {
    func excute(completion: @escaping (Result<FilterList, NetworkError>) -> Void)
}


final class DefaultFetchFilterUseCase: FetchFilterUseCase {
    
    private var networkManager: NetworkManagerable
    private var cancelBag = Set<AnyCancellable>()
    
    init(networkManager: NetworkManagerable) {
        self.networkManager = networkManager
    }
    
}


extension DefaultFetchFilterUseCase {
    
    func excute(completion: @escaping (Result<FilterList, NetworkError>) -> Void) {
        let users = networkManager.get(path: "/users", type: [User].self)
        let labels = networkManager.get(path: "/labels", type: [Label].self)
        let milestones = networkManager.get(path: "/milestones", type: [Milestone].self)
        
        users
            .zip(labels, milestones)
            .sink { error in
                switch error {
                case .failure(let error): completion(.failure(error))
                case .finished: break
                }
            } receiveValue: { users, labels, milestones in
                let filter = FilterList(users: users, labels: labels, mileStone: milestones)
                completion(.success(filter))
            }.store(in: &cancelBag)
    }
    
}


final class MockFilterUseCase: FetchFilterUseCase {
    
    func excute(completion: @escaping (Result<FilterList, NetworkError>) -> Void) {
        completion(.success(FilterListMock.data))
    }
    
}
