//
//  Feature.swift
//  
//
//  Created by Anton Pomozov on 15.07.2021.
//

import Foundation

struct Feature {
    let id: Int
    let name: String
    let enabled: Bool
    let till: Date?
}

extension Feature: Decodable {}
