import XCTest
@testable import FeatureVotingApp

final class FeatureVotingAppTests: XCTestCase {

    func testUserModel() {
        let user = User(id: 1, name: "Rafael", email: "rafael@example.com")
        XCTAssertEqual(user.name, "Rafael")
    }

    func testFeatureModel() {
        let feature = Feature(id: 1, title: "Dark Mode", description: "Enable dark theme", votes_count: 5)
        XCTAssertEqual(feature.votes_count, 5)
    }

    func testDuplicateVoteErrorMessage() {
        let api = APIService()
        let expectation = self.expectation(description: "Vote Error")

        // Simulating duplicate vote (mock call)
        api.voteFeature(featureId: 1, userId: 1) { success, message in
            XCTAssertFalse(success)
            XCTAssertEqual(message, "User has already voted for this feature")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }
}