//
//  PostImageFileUseCase.swift
//  IssueTracker
//
//  Created by 지북 on 2021/06/21.
//

import Foundation
import Combine

protocol UploadImageUseCase {
    func excute(data: Data?, completion: @escaping (Result<ImageFile, NetworkError>) -> Void)
}

final class DefaultUploadImageUseCase: UploadImageUseCase {
    
    private var networkManager: NetworkManagerable
    private var cancelBag = Set<AnyCancellable>()
    
    init(_ networkManager: NetworkManagerable) {
        self.networkManager = networkManager
    }
    
    func excute(data: Data?, completion: @escaping (Result<ImageFile, NetworkError>) -> Void) {
        networkManager.imageUpload(path: "/files", data: data, result: ImageFile.self)
            .receive(on: DispatchQueue.main)
            .sink { error in
                switch error {
                case .failure(let error): completion(.failure(error))
                case .finished : break
                }
            } receiveValue: { imageFile in
                completion(.success(imageFile))
            }.store(in: &cancelBag)

    }
    
}
