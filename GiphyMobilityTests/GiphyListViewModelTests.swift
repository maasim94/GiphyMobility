//
//  GiphyListViewModelTests.swift
//  GiphyMobilityTests
//
//  Created by Arslan Asim on 16/03/2019.
//

import XCTest
@testable import GiphyMobility

class GiphyListViewModelTests: XCTestCase {
    
    var sut: GiphyListViewModel!
    var mockGiphyDataFetcher: MockGiphyDataFetcher!
    override func setUp() {
        super.setUp()
        mockGiphyDataFetcher = MockGiphyDataFetcher()
        sut = GiphyListViewModel(dataFetcher: MockGiphyDataFetcher())
        sut.viewDidLoad(0)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        mockGiphyDataFetcher = nil
    }
    func testOutputAttributes() {
        XCTAssertEqual(sut.numberOfItems , mockGiphyDataFetcher.gifys.count)
        XCTAssertEqual(sut.title, "GIPHY LIST")
    }
    func testDataModelForIndexPath() {
        let indexPath = IndexPath(row: 0, section: 0)
        let giphyImageSet = (mockGiphyDataFetcher.gifys[indexPath.row]).imageSetClosestTo(width: 0)
        XCTAssertEqual(giphyImageSet, sut.getCurrentGifySet(for: indexPath.row, ofWidth: 0))
    }
    func testDataModelForSelectionIndexPath() {
        let indexPath = IndexPath(row: 0, section: 0)
        let giphyItem = mockGiphyDataFetcher.gifys[indexPath.row]
        XCTAssertEqual(giphyItem, sut.getCurrentGiphyItem(for: indexPath.row))
    }

    
}
// MARK: MockGiphyDataFetcher
/// A mock for data fetcher to provide test data.
class MockGiphyDataFetcher: GiphyDataFetcherProtocol {
    fileprivate var maxSizeInBytes: Int = 2048000 // 2MB size cap of gif
    var gifys:[GiphyItem] = []
    var fullGIFResponse: GiphyResponse?
    init() {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "sampleJSON", ofType: "json") else {
            return
        }
        let JSONString = try! String(contentsOfFile: path)
        let giphy = GiphyResponse(JSONString: JSONString)
        fullGIFResponse = giphy
        gifys = giphy!.gifsSmallerThan(sizeInBytes: maxSizeInBytes, forWidth: 0)
        
    }
    func fetchTrendingGifs(limit: Int, offset: Int?, completion: GiphyResponseBlock?) {
        completion?(nil,fullGIFResponse)
    }
}
