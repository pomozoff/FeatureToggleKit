//
//  JSONSource.swift
//  
//
//  Created by Anton Pomozov on 15.07.2021.
//

import Foundation

public class JSONSource<T: Feature> {
    public init(fileUrl: URL) {
        self.fileUrl = fileUrl
    }

    private let fileUrl: URL
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}

extension JSONSource: Source {
    enum Error: Swift.Error {
        case noContent
    }

    public func fetch(completion: @escaping (Result<[T], Swift.Error>) -> Void) {
        let data: Data
        do {
            data = try Data(contentsOf: fileUrl)
        } catch {
            return completion(.failure(Error.noContent))
        }

        do {
            let features = try decoder.decode([T].self, from: data)
            completion(.success(features))
        } catch {
            completion(.failure(error))
        }
    }
}