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
}

extension JSONSource: Source {
    public func fetch() -> [Feature] {
        guard let data = try? Data(contentsOf: fileUrl),
              let features = try? JSONDecoder().decode([Feature].self, from: data)
        else { return [] }
        return features
    }
}
