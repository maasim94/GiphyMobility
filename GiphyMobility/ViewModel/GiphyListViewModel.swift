//
//  GiphyListViewModel.swift
//  GiphyMobility
//
//  Created by Arslan Asim on 16/03/2019.
//
import AlamofireObjectMapper
import Alamofire

class GiphyListViewModel {
    // MARK: - properties
    private var dataFetcher: GiphyDataFetcherProtocol
    private var maxSizeInBytes: Int = 2048000 // 2MB size cap of gif
    private var isTrendingPageLoadInProgress: Bool = false
    private var latestGiphyResponse: GiphyResponse?
    private var pageOffset: Int = 0
    private var currentGifs: [GiphyItem] = [] {
        didSet {
            refreshCollectionData?()
        }
    }
    // output
    var refreshCollectionData: (() -> Void)?
    let title = "GIPHY LIST"
    // Input
    var viewDidLoad: (_ expectedWidth:CGFloat) -> Void = { _ in }
    // MARK: - init
    init(dataFetcher: GiphyDataFetcherProtocol) {
        self.dataFetcher = dataFetcher
        viewDidLoad = { [weak self] expectedWidth in
            self?.getNextTrendingDataPage(ofWidth: expectedWidth)
        }
    }
    // MARK: - api
    private func getNextTrendingDataPage(ofWidth width: CGFloat) {
        guard !isTrendingPageLoadInProgress else {
            return
        }
        isTrendingPageLoadInProgress = true
        dataFetcher.fetchTrendingGifs(limit: 25, offset: pageOffset) { [weak self] (error, response) in
            guard let strongSelf  = self else { return }
            strongSelf.isTrendingPageLoadInProgress = false
            guard error == nil else {
                // show error alert
                return
            }
            strongSelf.latestGiphyResponse = response
            strongSelf.pageOffset = (response?.pagination?.offset ?? strongSelf.pageOffset) + (response?.pagination?.count ?? 0)
            let items = response?.gifsSmallerThan(sizeInBytes: strongSelf.maxSizeInBytes, forWidth: width) ?? []
            strongSelf.currentGifs.append(contentsOf: items)
        }
    }
    // MARK: - businsess logic
    let numberOfSections: Int = 1
    /// Get number of items in collectionview
    var numberOfItems: Int {
        return currentGifs.count
    }
    /// Get ImageSet to show in cell
    ///
    /// - Parameters:
    ///   - index: index of Cell
    ///   - width: expected width
    /// - Returns: optional image set
    func getCurrentGifySet(for index:Int, ofWidth width:CGFloat) -> GiphyImageSet? {
        let gif = currentGifs[index].imageSetClosestTo(width: width)
        return gif
    }
    
    /// Get Giphy Item which has images sets underneth
    ///
    /// - Parameter index: index of cell
    /// - Returns: GiphyItem
    func getCurrentGiphyItem(for index:Int) -> GiphyItem {
        return currentGifs[index]
    }
    /// Ask view model to fetach next page if conditions meet
    ///
    /// - Parameter withWidth: expected width
    func askForNextPage(withWidth: CGFloat) {
        if canAskForNextPage() {
            getNextTrendingDataPage(ofWidth: withWidth)
        }
    }
    /// Check when user scroll to bottom of page if new api could be make
    ///
    /// - Returns: if true call for api, else not
    private func canAskForNextPage() -> Bool {
        if !isTrendingPageLoadInProgress && latestGiphyResponse != nil {
            return true
        }
        return false
    }
    
}
