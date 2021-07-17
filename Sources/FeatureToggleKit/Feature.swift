//
//  File.swift
//  
//
//  Created by Anton Pomozov on 17.07.2021.
//

import Foundation

public protocol Feature: Hashable, Decodable {
    var name: String { get }
    var isEnabled: Bool { get }
}
