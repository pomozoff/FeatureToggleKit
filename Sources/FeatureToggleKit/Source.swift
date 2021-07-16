//
//  Source.swift
//  
//
//  Created by Anton Pomozov on 15.07.2021.
//

import Foundation

public protocol Source: AnyObject {
    
}

protocol Fetchable: AnyObject {
    func fetch(completion: @escaping (Result<[Feature], Swift.Error>) -> Void)
}
