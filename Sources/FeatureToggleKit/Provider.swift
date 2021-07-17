//
//  Provider.swift
//  
//
//  Created by Anton Pomozov on 15.07.2021.
//

import CommonKit
import Foundation

/**
 The provider contains a list of feature sources where features could be fetched from.
 */
public class Provider<T: Feature> {
    public static func createProvider(with sources: [AnySource<T>]) -> Provider<T> {
        .init(sources: sources)
    }

    init(sources: [AnySource<T>]) {
        self.sources = sources
    }

    private let sources: [AnySource<T>]
    private let featuresUpdateSemaphore = DispatchSemaphore(value: 1)

    @Atomic
    private var features: [T: Bool] = [:]
}

extension Provider {
    /**
     Fetch available features from sources of the provider.
     Features from the latest sources override previous ones.
     */
    public func fetch(features: [T], completion: @escaping (Result<Void, Error>) -> Void) {
        for source in sources {
            source.fetch { [weak self] result in
                guard let self = self else { return }

                switch result {
                case let .success(features):
                    self.featuresUpdateSemaphore.wait()

                    self.features = features.reduce(into: self.features) { result, feature in
                        result[feature] = feature.isEnabled
                    }

                    self.featuresUpdateSemaphore.signal()
                case let .failure(error):
                    return completion(.failure(error)) // TODO: Create chained error list
                }
            }
        }
        completion(.success(()))
    }

    /**
     Check if the feature is enabled.
     If the feature is absent it is disabled.
     */
    public func isFeatureEnabled(_ feature: T) -> Bool {
        features[feature] ?? false
    }
}
