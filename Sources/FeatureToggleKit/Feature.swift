//
//  File.swift
//  
//
//  Created by Anton Pomozov on 17.07.2021.
//

import Foundation

public typealias DecodableFeature = Feature & Decodable

public protocol Feature: Hashable {
    var name: String { get }
    var isEnabled: Bool { get }
}
