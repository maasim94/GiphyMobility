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
    fileprivate var imageSetsForConsideration: [GiphyImageSet] = []
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
        
        var imageSetsForConsiderationOptional = [GiphyImageSet?]()
        imageSetsForConsiderationOptional.append(fixedHeightImage)
        imageSetsForConsiderationOptional.append(fixedHeightDownsampledImage)
        imageSetsForConsiderationOptional.append(fixedWidthImage)
        imageSetsForConsiderationOptional.append(fixedWidthDownsampledImage)
        imageSetsForConsiderationOptional.append(fixedHeightSmallImage)
        imageSetsForConsiderationOptional.append(fixedWidthSmallImage)
        imageSetsForConsiderationOptional.append(downsizedImage)
        imageSetsForConsiderationOptional.append(downsizedLargeImage)
        imageSetsForConsiderationOptional.append(originalImage)
        imageSetsForConsideration = imageSetsForConsiderationOptional.compactMap({$0})
        
    }
    
    /// get imageSet to show to user
    ///
    /// - Parameter width: expected width of image
    /// - Returns: opional ImageSet
    func imageSetClosestTo(width: CGFloat) -> GiphyImageSet? {
        // Search for matches
        guard imageSetsForConsideration.count > 0 else {
            return nil
        }
        if let closestValue = imageSetsForConsideration.enumerated().min(by: { abs($0.1.width - Int(width)) < abs($1.1.width - Int(width)) }) {
            return closestValue.element
        }
        // we want to return somthing if we don't have value above
        return imageSetsForConsideration[0]
    }
}
