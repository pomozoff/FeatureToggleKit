import XCTest
@testable import FeatureToggleKit

final class FeatureToggleKitTests: XCTestCase {
    func testPlistSource() {
        guard let url = Bundle.module.url(forResource: "featuresList2", withExtension: "plist") else {
            return XCTFail("File not found")
        }
        let source = PlistSource(fileUrl: url)
        let features = source.fetch()

        XCTAssert(features.count == 2, "Invalid count of features")
    }
}
