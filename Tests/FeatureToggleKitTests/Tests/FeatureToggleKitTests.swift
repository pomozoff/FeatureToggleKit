import XCTest
@testable import FeatureToggleKit

final class FeatureToggleKitTests: XCTestCase {
    func testPlistSource() {
        guard let url = Bundle.module.url(forResource: "featuresList2", withExtension: "plist") else {
            return XCTFail("File not found")
        }

        let expectation = XCTestExpectation(description: "Fetch features from a plist file")
        PlistSource<FeatureModel>(fileUrl: url).fetch { result in
            switch result {
            case let .success(features):
                XCTAssert(features.count == 2, "Invalid count of features")
                XCTAssert(features.first!.till != nil, "Invalid date")
            case let .failure(error):
                XCTFail("Failure: \(error)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: Constants.defaultTimeout)
    }

    func testJSONSource() {
        guard let url = Bundle.module.url(forResource: "featuresList1", withExtension: "json") else {
            return XCTFail("File not found")
        }

        let expectation = XCTestExpectation(description: "Fetch features from a JSON file")
        JSONSource<FeatureModel>(fileUrl: url).fetch { result in
            switch result {
            case let .success(features):
                XCTAssert(features.count == 3, "Invalid count of features")
                XCTAssert(features.first!.till != nil, "Invalid date")
            case let .failure(error):
                XCTFail("Failure: \(error)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: Constants.defaultTimeout)
    }
}

private enum Constants {
    static let defaultTimeout = 1.0
}
