//
//  FeatureError.swift
//  LeoCalc
//
//  Created by Anton Pomozov on 25.07.2021.
//

import CommonKit
import Foundation

public enum FeatureErrorCode: Int, BaseErrorCode {
    case decode = 0
    case noContent

    public var localizedDescription: String {
        switch self {
        case .decode:
            return "Decoding error"
        case .noContent:
            return "No content"
        }
    }
}

public class FeatureError: BaseError<FeatureErrorCode> {
    public override var domainShortName: String { "FT" }
}
