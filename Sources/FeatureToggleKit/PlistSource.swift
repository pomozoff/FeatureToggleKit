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

extension PlistSource: Source {
    public func fetch() -> [Feature] {
        guard let xml = FileManager.default.contents(atPath: fileUrl.path),
              let features = try? PropertyListDecoder().decode([Feature].self, from: xml)
        else { return [] }
        return features
    }
}
