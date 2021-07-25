//
//  ProviderError.swift
//  
//
//  Created by Anton Pomozov on 25.07.2021.
//

import Foundation

import CommonKit
import Foundation

public enum ProviderErrorCode: Int, BaseErrorCode {
    case fetch = 0

    public var localizedDescription: String {
        switch self {
        case .fetch: return "Fetch features error"
        }
    }
}

public class ProviderError: BaseError<ProviderErrorCode> {
    public override var domainShortName: String { "PR" }
}

