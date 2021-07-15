//
//  PlistSource.swift
//  
//
//  Created by Anton Pomozov on 15.07.2021.
//

import Foundation

class PlistSource {
    init(fileUrl: URL) {
        self.fileUrl = fileUrl
    }

    private let fileUrl: URL
}

extension PlistSource: Source {
    func fetch() -> [Feature] {
        guard let path = Bundle.main.path(forResource: fileUrl.absoluteString, ofType: ""),
              let xml = FileManager.default.contents(atPath: path),
              let plist = try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil),
              let features = plist as? [Feature]
        else { return [] }
        return features
    }
}
