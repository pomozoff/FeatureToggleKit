//
//  PlistSource.swift
//  
//
//  Created by Anton Pomozov on 15.07.2021.
//

import Foundation

public class PlistSource<T: DecodableFeature> {
    public init(fileUrl: URL) {
        self.fileUrl = fileUrl
    }

    private let fileUrl: URL
}

extension PlistSource: Source {
    public func fetch(completion: @escaping (Result<[T], Swift.Error>) -> Void) {
        guard let xml = FileManager.default.contents(atPath: fileUrl.path) else {
            return completion(.failure(FeatureError(code: .noContent)))
        }

        do {
            let features = try PropertyListDecoder().decode([T].self, from: xml)
            completion(.success(features))
        } catch {
            completion(.failure(FeatureError(code: .decode, underlying: error)))
        }
    }
}
