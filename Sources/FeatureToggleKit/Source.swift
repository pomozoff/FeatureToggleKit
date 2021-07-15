//
//  Source.swift
//  
//
//  Created by Anton Pomozov on 15.07.2021.
//

import Foundation

public protocol Source {
    func fetch() -> [Feature]
}
