//
//  JSONSource.swift
//  
//
//  Created by Anton Pomozov on 15.07.2021.
//

import Foundation

class JSONSource {
    init(fileUrl: URL) {
        self.fileUrl = fileUrl
    }

    private let fileUrl: URL
}

extension JSONSource: Source {
    func fetch() -> [Feature] {
        guard let data = try? Data(contentsOf: fileUrl),
              let features = try? JSONDecoder().decode([Feature].self, from: data)
        else { return [] }
        return features
    }
}
