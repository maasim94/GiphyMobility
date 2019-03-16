//
//  GiphyNetwork.swift
//  GiphyMobility
//
//  Created by Arslan Asim on 16/03/2019.
//

import Foundation
import Alamofire
import AlamofireObjectMapper


typealias GiphyResponseBlock = (_ error: AppError?, _ response: GiphyResponse?) -> Void
enum AppError: Error {
    case gernalError(message: String)
}
protocol GiphyDataFetcherProtocol {
    func fetchTrendingGifs(limit: Int, offset: Int?,completion: GiphyResponseBlock?)
}
class GiphyDataFetcher: GiphyDataFetcherProtocol  {
    
    private struct Constant {
        static let apiKey = "lUw43tyyf5QO9jfII2utDkSVTWLsfa0T"
        static let giphyURL = "https://api.giphy.com/v1/gifs/trending"
        static let unknownResponse = NSLocalizedString("The server returned an unknown response.", comment: "The error message shown when the server produces something unintelligible.")
          static let urlNotGood = NSLocalizedString("URL requested is not good", comment: "The error message shown when server accessing url is not good.")
    }    
    /// Get the currently trending gifs from Giphy
    ///
    /// - Parameters:
    ///   - limit:The limit of results to fetch
    ///   - offset: The paging offset
    ///   - completion: The completion block to call when done
    func fetchTrendingGifs(limit: Int, offset: Int?, completion: GiphyResponseBlock?) {
        guard let url = URL(string:Constant.giphyURL) else {
            // incorporate error
            completion?(AppError.gernalError(message: Constant.urlNotGood), nil)
            return
        }
        var params = [String : Any]()
        params["api_key"] = Constant.apiKey
        params["limit"] = limit
        if let currentOffset = offset {
            params["offset"] = currentOffset
        }
        let request = Alamofire.request(url, method: .get, parameters: params)
        request.responseObject { (responseData:DataResponse<GiphyResponse>) in
            if let gifs = responseData.result.value {
                DispatchQueue.main.async {
                    completion?(nil, gifs)
                }
            } else {
                let errorDes = responseData.result.error?.localizedDescription ?? Constant.unknownResponse
                completion?(AppError.gernalError(message:errorDes), nil)
            }
        }
    }
}
