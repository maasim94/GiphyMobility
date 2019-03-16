//
//  GiphyAPIResponse.swift
//  GiphyMobility
//
//  Created by Arslan Asim on 16/03/2019.
//


import Foundation
import ObjectMapper

struct GiphyResponse: Mappable {
    
    fileprivate(set) var gifs: [GiphyItem] = [GiphyItem]()
    fileprivate(set) var pagination: GiphyPagination?

    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        gifs        <- map["data"]
        pagination  <- map["pagination"]
    }
    
    /// get gids smaller given size
    ///
    /// - Parameters:
    ///   - sizeInBytes: size of images required
    ///   - forWidth: expected width
    /// - Returns: collection of GiphyItem
    func gifsSmallerThan(sizeInBytes: Int, forWidth: CGFloat) -> [GiphyItem] {
        return gifs.filter({
            let size = $0.imageSetClosestTo(width: forWidth)?.size ?? 0
            
            guard size > 0 else {
                return false
            }
            
            return size <= sizeInBytes
        })
    }
}
