//
//  GiphyModelTests.swift
//  GiphyMobilityTests
//
//  Created by Arslan Asim on 16/03/2019.
//

import XCTest
@testable import GiphyMobility

class GiphyModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testImageSetAttributes() {
        let testURLString = "https://media3.giphy.com//media//8vEZSnXvT4OrY7ScSz//100_s.gif?cid=e1bb72ff5c88e3562e536a5a41e2ab63"
        let sampleJSON: [String: Any] = [ "url":testURLString,
                                          "width":"500",
                                          "height":"281",
                                          "size":"85008"
        ]
        let imageSet = GiphyImageSet(JSON: sampleJSON)
        XCTAssertNotNil(imageSet)
        XCTAssertEqual(imageSet!.height, 281)
        XCTAssertEqual(imageSet!.width, 500)
        XCTAssertEqual(imageSet!.size, 85008)
        XCTAssertEqual(imageSet!.url, URL(string: testURLString))
    }

}
