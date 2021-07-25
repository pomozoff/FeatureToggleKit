//
//  Providable.swift
//  
//
//  Created by Anton Pomozov on 25.07.2021.
//

import Foundation

public protocol Providable: AnyObject {
    func fetch(completion: @escaping (Result<Void, ProviderError>) -> Void)
}
