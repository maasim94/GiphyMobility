//
//  GiphyMobilityUITests.swift
//  GiphyMobilityUITests
//
//  Created by Arslan Asim on 16/03/2019.
//

import XCTest

class GiphyMobilityUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFullScreenGifShow() {
        let app = XCUIApplication()
        let collectionView = app.collectionViews["gifCollection"]
        XCTAssert(collectionView.waitForExistence(timeout: 5))
        collectionView.cells.element(boundBy: 0).tap()
        let fullScreenView = app.otherElements["fullScreenGif"]
        let fullScreenViewShown = fullScreenView.waitForExistence(timeout: 5)
        XCTAssert(fullScreenViewShown)
    }

}
