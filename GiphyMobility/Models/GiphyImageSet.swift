//
//  GiphyImageSet.swift
//  GiphyMobility
//
//  Created by Arslan Asim on 16/03/2019.
//


import Foundation
import ObjectMapper

struct GiphyImageSet: Mappable, Equatable {
    
    fileprivate(set) var url: URL?
    fileprivate(set) var width: Int = 0
    fileprivate(set) var height: Int = 0
    fileprivate(set) var size: Int = 0
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        url                 <- (map["url"], URLTransform())
        width               <- (map["width"], stringToIntTransform)
        height              <- (map["height"], stringToIntTransform)
        size                <- (map["size"], stringToIntTransform)
    }
}
