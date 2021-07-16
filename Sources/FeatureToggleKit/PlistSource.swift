//
//  PlistSource.swift
//  
//
//  Created by Anton Pomozov on 15.07.2021.
//

import Foundation

public class PlistSource {
    public init(fileUrl: URL) {
        self.fileUrl = fileUrl
    }

    private let fileUrl: URL
}

extension PlistSource: Source {}

extension PlistSource: Fetchable {
    enum Error: Swift.Error {
        case noContent
    }

    func fetch(completion: @escaping (Result<[Feature], Swift.Error>) -> Void) {
        guard let xml = FileManager.default.contents(atPath: fileUrl.path) else {
            return completion(.failure(Error.noContent))
        }

        do {
            let features = try PropertyListDecoder().decode([Feature].self, from: xml)
            completion(.success(features))
        } catch {
            completion(.failure(error))
        }
    }
}
