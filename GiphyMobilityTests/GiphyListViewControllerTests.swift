//
//  GiphyListViewControllerTests.swift
//  GiphyMobilityTests
//
//  Created by Arslan Asim on 16/03/2019.
//

import XCTest

@testable import GiphyMobility
class GiphyListViewControllerTests: XCTestCase {

    var viewControllerUnderTest : GiphyListViewController!
    override func setUp() {
        super.setUp()
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        viewControllerUnderTest = storyboard.instantiateViewController(withIdentifier: "GiphyListViewController") as? GiphyListViewController
        //load view hierarchy
        if(viewControllerUnderTest != nil) {
            viewControllerUnderTest.loadView()
            viewControllerUnderTest.viewDidLoad()
        }
    }

    override func tearDown() {
        super.tearDown()
        viewControllerUnderTest = nil
    }
    //MARK:- Collectionview
    func testViewControllerIsComposeOfTableView() {
        XCTAssertNotNil(viewControllerUnderTest.collectionView,"ViewController under test is not composed of a UICollectionView")
    }
    func testControllerConformsToCollectionViewDelegate() {
        XCTAssertNotNil(viewControllerUnderTest.conforms(to: UICollectionViewDelegate.self),"ViewController under test  does not conform to UICollectionViewDelegate protocol")
    }
    func testControllerConformsToCollectionViewDataSource() {
        XCTAssertNotNil(viewControllerUnderTest.conforms(to: UICollectionViewDataSource.self),"ViewController under test  does not conform to UICollectionViewDataSource protocol")
    }
    func testCollectionViewDelegateIsSet() {
        XCTAssertNotNil(self.viewControllerUnderTest.collectionView.delegate)
    }
    func testCollectionViewDataSourceIsSet() {
        XCTAssertNotNil(self.viewControllerUnderTest.collectionView.dataSource)
    }
    func testCollectionLayout() {
        XCTAssert(viewControllerUnderTest.collectionView.collectionViewLayout is GiphyGridLayout, "Collection view layout needs to be GiphyGridLayout")
    }
    // MARK: - segue tests
    func testManufacturerHasSegueToModels(){
        let targetIdentifier = "toFullScreenGIF"
        XCTAssert(hasSegueWithIdentifier(id: targetIdentifier), "GiphyListViewController view controller must have target segue to Details")
    }
    func hasSegueWithIdentifier(id: String) -> Bool {
        
        let segues = viewControllerUnderTest.value(forKey: "storyboardSegueTemplates") as? [NSObject]
        let filtered = segues?.filter({ $0.value(forKey:"identifier") as? String == id })
        if let filter = filtered {
            return filter.count > 0
        }
        return false
    }
}
