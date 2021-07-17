//
//  FeatureModel.swift
//  
//
//  Created by Anton Pomozov on 15.07.2021.
//

import FeatureToggleKit
import Foundation

struct FeatureModel {
    let id: Int
    let name: String
    let enabled: Bool
    let till: Date?
}

extension FeatureModel: Feature {
    var isEnabled: Bool {
        enabled && (till.map { $0 < Date() } ?? true)
    }
}

extension FeatureModel: Decodable {}
