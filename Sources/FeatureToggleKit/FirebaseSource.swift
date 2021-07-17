//
//  FirebaseSource.swift
//  
//
//  Created by Anton Pomozov on 15.07.2021.
//

import Foundation

public class FirebaseSource<T: Feature> {}

extension FirebaseSource: Source {
    enum Error: Swift.Error {
        case noContent
    }

    public func fetch(completion: @escaping (Result<[T], Swift.Error>) -> Void) {
        // TODO: Implement later
        completion(.failure(Error.noContent))
    }
}
