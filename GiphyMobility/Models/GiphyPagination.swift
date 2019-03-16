//
//  GiphyPagination.swift
//  GiphyMobility
//
//  Created by Arslan Asim on 16/03/2019.
//


import Foundation
import ObjectMapper

struct GiphyPagination: Mappable {
    
    fileprivate(set) var count: Int = 0
    fileprivate(set) var offset: Int = 0
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        count   <- map["count"]
        offset  <- map["offset"]
    }
}
