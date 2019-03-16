//
//  GiphyItem.swift
//  GiphyMobility
//
//  Created by Arslan Asim on 16/03/2019.
//


import Foundation
import ObjectMapper

struct GiphyItem: Mappable, Equatable {
    
    fileprivate(set) var type: String = "gif"
    fileprivate(set) var identifier: String = ""
    fileprivate(set) var title: String = ""
    // MARK: Image options that are available
    
    fileprivate(set) var fixedHeightImage: GiphyImageSet?
    fileprivate(set) var fixedHeightDownsampledImage: GiphyImageSet?
    fileprivate(set) var fixedWidthImage: GiphyImageSet?
    fileprivate(set) var fixedWidthDownsampledImage: GiphyImageSet?
    fileprivate(set) var fixedHeightSmallImage: GiphyImageSet?
    fileprivate(set) var fixedWidthSmallImage: GiphyImageSet?
    fileprivate(set) var downsizedImage: GiphyImageSet?
    fileprivate(set) var downsizedLargeImage: GiphyImageSet?
    fileprivate(set) var originalImage: GiphyImageSet?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        
        type                            <- map["type"]
        identifier                      <- map["id"]
        title                           <- map["title"]
        fixedHeightImage                <- map["images.fixed_height"]
        fixedHeightDownsampledImage     <- map["images.fixed_height_downsampled"]
        fixedWidthImage                 <- map["images.fixed_width"]
        fixedWidthDownsampledImage      <- map["images.fixed_width_downsampled"]
        fixedHeightSmallImage           <- map["images.fixed_height_small"]
        fixedWidthSmallImage            <- map["images.fixed_width_small"]
        downsizedImage                  <- map["images.downsized"]
        downsizedLargeImage             <- map["images.downsized_large"]
        originalImage                   <- map["images.original"]
    }
    
    /// get imageSet to show to user
    ///
    /// - Parameter width: expected width of image
    /// - Returns: opional ImageSet
    func imageSetClosestTo(width: CGFloat) -> GiphyImageSet? {
        
        var imageSetsForConsideration = [GiphyImageSet]()
        if fixedHeightImage != nil {
            imageSetsForConsideration.append(fixedHeightImage!)
        }
        if fixedHeightDownsampledImage != nil {
            imageSetsForConsideration.append(fixedHeightDownsampledImage!)
        }
        if fixedWidthImage != nil {
            imageSetsForConsideration.append(fixedWidthImage!)
        }
        
        if fixedWidthDownsampledImage != nil {
            imageSetsForConsideration.append(fixedWidthDownsampledImage!)
        }
        
        if fixedHeightSmallImage != nil {
            imageSetsForConsideration.append(fixedHeightSmallImage!)
        }
        
        if fixedWidthSmallImage != nil {
            imageSetsForConsideration.append(fixedWidthSmallImage!)
        }
        
        if downsizedImage != nil {
            imageSetsForConsideration.append(downsizedImage!)
        }
        
        if downsizedLargeImage != nil {
            imageSetsForConsideration.append(downsizedLargeImage!)
        }
        
        if originalImage != nil {
            imageSetsForConsideration.append(originalImage!)
        }
        // Search for matches
        
        guard imageSetsForConsideration.count > 0 else {
            return nil
        }
        
        var currentClosestSizeMatch: GiphyImageSet = imageSetsForConsideration[0]
        
        for item in imageSetsForConsideration
        {
            if item.width >= Int(width) && item.width < currentClosestSizeMatch.width
            {
                currentClosestSizeMatch = item
            }
        }
        
        return currentClosestSizeMatch
    }
}
