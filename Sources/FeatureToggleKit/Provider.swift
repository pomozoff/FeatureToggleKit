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
public class Provider<Model: DecodableFeature, Storage: Feature> {
    public init(sources: [AnySource<Model>], mapper: @escaping (Model) -> Storage?) {
        self.sources = sources
        self.mapper = mapper
    }

    private let sources: [AnySource<Model>]
    private let mapper: (Model) -> Storage?
    private let featuresUpdateSemaphore = DispatchSemaphore(value: 1)

    @Atomic
    private var features: [Storage: Bool] = [:]
}

extension Provider {
    /**
     Fetch available features from sources of the provider.
     Features from the latest sources override previous ones.

     Successful completion closure will be called for each source successfully fetched, e.g.,
     there are three sources, and features from all of them are fetched without errors,
     then the completion closure will be called three times. This allows a client to start
     updating UI as soon as the fastest source returns features.
     */
    public func fetch(features: [Model], completion: @escaping (Result<Void, Error>) -> Void) {
        for source in sources {
            source.fetch { [weak self] result in
                guard let self = self else { return }

                switch result {
                case let .success(features):
                    self.featuresUpdateSemaphore.wait()

                    self.features = features.reduce(into: self.features) { result, feature in
                        self.mapper(feature).map {
                            result[$0] = feature.isEnabled
                        }
                    }

                    self.featuresUpdateSemaphore.signal()
                case let .failure(error):
                    return completion(.failure(error)) // TODO: Create chained error list
                }
            }
            completion(.success(()))
        }
    }

    /**
     Check if the feature is enabled.
     If the feature is absent it is disabled.
     */
    public func isFeatureEnabled(_ feature: Storage) -> Bool {
        features[feature] ?? false
    }
}
