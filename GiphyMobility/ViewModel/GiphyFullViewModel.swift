//
//  GiphyFullViewModel.swift
//  GiphyMobility
//
//  Created by Arslan Asim on 16/03/2019.
//

import Foundation
import UIKit

class GiphyFullViewModel {
    //MARK:- properties
    private let giphyImageSet: GiphyItem
    //MARK:- init
    init(imageSet: GiphyItem) {
        self.giphyImageSet = imageSet
    }
    //MARK:- busniness logic
    func gifURL(forWidth width: CGFloat) -> URL? {
        return giphyImageSet.imageSetClosestTo(width: width)?.url
    }
    var title: String {
        return giphyImageSet.title
    }
}
