///**
 /**
 
 GiphyNetworkTests
 GiphyMobilityTests
 Created by: Oliver Lance on 2019-03-25
 
 
 */

import XCTest
@testable import GiphyMobility

class GiphyNetworkTests: XCTestCase {

    var sut: GiphyDataFetcher!
    var mockNetwork: MockNetwrok!

    override func setUp() {
        let dummyURL = URL(string: "https://www.google.com/")!
        sut = GiphyDataFetcher(url:dummyURL , network: MockNetwrok())
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testDataFetch() {
        sut.fetchTrendingGifs(limit: 0, offset: 0) { (error, response) in
            XCTAssertNotNil(response)
            XCTAssertNil(error)
        }
    }

}
// MARK: MockNetwork
/// A mock for data fetcher to provide test data.

class MockNetwrok: NetworkClient {
    func fetchData(from url: URL, params: [String : Any], completion: GiphyResponseBlock?) {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "sampleJSON", ofType: "json")!
        let JSONString = try! String(contentsOfFile: path)
        let giphy = GiphyResponse(JSONString: JSONString)
        completion?(nil, giphy)
    }
}
