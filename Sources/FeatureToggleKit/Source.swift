//
//  Source.swift
//  
//
//  Created by Anton Pomozov on 15.07.2021.
//

import Foundation

public protocol Source: AnyObject {
    associatedtype Feature

    func fetch(completion: @escaping (Result<[Feature], Swift.Error>) -> Void)
}

public class AnySource<Feature>: Source {
    init<FeatureSource: Source>(wrappedSource: FeatureSource) where FeatureSource.Feature == Feature {
        self.fetchFeatures = wrappedSource.fetch
    }

    public func fetch(completion: @escaping (Result<[Feature], Swift.Error>) -> Void) {
        fetchFeatures(completion)
    }

    private let fetchFeatures: (@escaping (Result<[Feature], Swift.Error>) -> Void) -> Void
}
