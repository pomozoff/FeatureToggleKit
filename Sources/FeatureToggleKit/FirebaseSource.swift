//
//  FirebaseSource.swift
//  
//
//  Created by Anton Pomozov on 15.07.2021.
//

import Foundation

public class FirebaseSource {}

extension FirebaseSource: Source {}

extension FirebaseSource: Fetchable {
    enum Error: Swift.Error {
        case noContent
    }

    func fetch(completion: @escaping (Result<[Feature], Swift.Error>) -> Void) {
        // TODO: Implement later
        completion(.failure(Error.noContent))
    }
}
