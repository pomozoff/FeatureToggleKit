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
public class Provider<M: DecodableFeature> {
    public init(sources: [AnySource<M>]) {
        self.sources = sources
    }

    private let sources: [AnySource<M>]
    private let featuresUpdateSemaphore = DispatchSemaphore(value: 1)

    @Atomic
    private var features: [String: M] = [:]
}

extension Provider: Providable {
    /**
     Fetch available features from sources of the provider.
     Features from the latest sources override previous ones.

     Successful completion closure will be called for each source successfully fetched, e.g.,
     there are three sources, and features from all of them are fetched without errors,
     then the completion closure will be called three times. This allows a client to start
     updating UI as soon as the fastest source returns features.
     */
    public func fetch(completion: @escaping (Result<Void, ProviderError>) -> Void) {
        for source in sources {
            self.featuresUpdateSemaphore.wait()

            source.fetch { [weak self] result in
                guard let self = self else { return }

                switch result {
                case let .success(models):
                    self.features = models.reduce(into: self.features) { result, model in
                        result[model.name] = model
                    }
                    completion(.success(()))
                case let .failure(error):
                    completion(.failure(ProviderError(code: .fetch, underlying: error)))
                }
                self.featuresUpdateSemaphore.signal()
            }
        }
    }

    /**
     Check if the feature is enabled.
     If the feature is absent it is disabled.
     */
    public func isFeatureEnabled(name: String) -> Bool {
        features[name]?.isEnabled ?? false
    }

    public func model(with name: String) -> M? {
        features[name]
    }
}
