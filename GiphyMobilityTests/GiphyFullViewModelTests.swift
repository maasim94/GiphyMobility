//
//  GiphyFullViewModelTests.swift
//  GiphyMobilityTests
//
//  Created by Arslan Asim on 16/03/2019.
//

import XCTest
@testable import GiphyMobility
class GiphyFullViewModelTests: XCTestCase {

    var sut: GiphyFullViewModel!
    override func setUp() {
        super.setUp()
        sut = GiphyFullViewModel(imageSet: prepareMockData())
    }
    func prepareMockData() -> GiphyItem {
        let sampleJSON: [String: Any] = [
            "type": "gif",
            "id": "8vEZSnXvT4OrY7ScSz",
            "title": "This is test title",
            "slug": "nbc-agt-screaming-americas-got-talent-8vEZSnXvT4OrY7ScSz",
            "images": [
                "fixed_width": [
                    "url": "https://media3.giphy.com/media/8vEZSnXvT4OrY7ScSz/200w.gif",
                    "width": "200",
                    "height": "112",
                    "size": "235005",
                ]
            ]
        ]
        let item = GiphyItem(JSON: sampleJSON)!
        return item
    }
    override func tearDown() {
        sut = nil
    }
    func testOutputAttributes() {
        XCTAssertEqual(sut.gifURL(forWidth: 0) , URL(string: "https://media3.giphy.com/media/8vEZSnXvT4OrY7ScSz/200w.gif"))
        XCTAssertEqual(sut.title, "This is test title")
    }

}
