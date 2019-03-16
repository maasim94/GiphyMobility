//
//  ParsingTransforms.swift
//  GiphyMobility
//
//  Created by Arslan Asim on 16/03/2019.
//


import Foundation
import ObjectMapper

let stringToIntTransform = TransformOf<Int, String>(fromJSON: { (value: String?) -> Int in
    return Int(value ?? "0") ?? 0
    }, toJSON: { (value: Int?) -> String? in
    // transform value from Int? to String?
    if let value = value {
        return String(value)
    }
    return nil
})
