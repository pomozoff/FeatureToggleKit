//
//  Provider.swift
//  
//
//  Created by Anton Pomozov on 15.07.2021.
//

import Foundation

public protocol Target {
    var name: String { get }
}

public class Provider<T: Target> {
    /**
     - Parameter sources: The list of feature sources
     */
    public init(sources: [Source]) {
        self.sources = sources
    }

    private let sources: [Source]
}
