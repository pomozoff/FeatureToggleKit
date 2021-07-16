//
//  JSONSource.swift
//  
//
//  Created by Anton Pomozov on 15.07.2021.
//

import Foundation

public class JSONSource {
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

extension JSONSource: Source {}

extension JSONSource: Fetchable {
    enum Error: Swift.Error {
        case noContent
    }

    func fetch(completion: @escaping (Result<[Feature], Swift.Error>) -> Void) {
        let data: Data
        do {
            data = try Data(contentsOf: fileUrl)
        } catch {
            return completion(.failure(Error.noContent))
        }

        do {
            let features = try decoder.decode([Feature].self, from: data)
            completion(.success(features))
        } catch {
            completion(.failure(error))
        }
    }
}
