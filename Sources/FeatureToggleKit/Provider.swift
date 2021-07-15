//
//  Provider.swift
//  
//
//  Created by Anton Pomozov on 15.07.2021.
//

import Foundation

class Provider {
    init(sources: [Source]) {
        self.sources = sources
    }

    private let sources: [Source]
}
