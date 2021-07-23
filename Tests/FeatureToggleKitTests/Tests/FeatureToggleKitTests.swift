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

    func testProvider() {
        let jsonSource = JSONSource<FeatureModel>(fileUrl: Bundle.module.url(forResource: "featuresList1", withExtension: "json")!)
        let plistSource = PlistSource<FeatureModel>(fileUrl: Bundle.module.url(forResource: "featuresList2", withExtension: "plist")!)

        let provider = Provider<FeatureModel>(
            sources: [jsonSource.anySource, plistSource.anySource]
        )

        var counter = 0
        let expectation = XCTestExpectation(description: "Fetch features from the provider")
        expectation.expectedFulfillmentCount = 2

        provider.fetch { result in
            switch result {
            case .success():
                counter == 0
                    ? XCTAssert(provider.isFeatureEnabled(name: "minus"), "Features is disabled")
                    : XCTAssert(!provider.isFeatureEnabled(name: "minus"), "Features is enabled")
                XCTAssert(!provider.isFeatureEnabled(name: "unknown feature"), "Features is enabled")
            case let .failure(error):
                XCTFail("Failure: \(error)")
            }
            expectation.fulfill()
            counter += 1
        }
        wait(for: [expectation], timeout: Constants.defaultTimeout)
    }
}

private enum Constants {
    static let defaultTimeout = 1.0
}
