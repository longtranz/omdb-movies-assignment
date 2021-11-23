//
//  OmdbNetwork.swift
//  OmdbMovies
//
//  Created by LongTM3 on 11/22/21.
//  Copyright © 2021 LongTM3. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

enum OmdbRouter: URLRequestConvertible {
    case search(query: String, page: Int)
    case detail(movieId: String)

    private var method: HTTPMethod {
        return .get
    }

    private var parameters: Parameters? {
        var params = [
            AppConstants.API.Parameters.apiKey: AppConstants.API.APIKey,
            AppConstants.API.Parameters.type: "movie"
        ]

        switch self {
        case .search(let query, let page):
            params.updateValue(query, forKey: AppConstants.API.Parameters.searchQuery)
            params.updateValue(String(page), forKey: AppConstants.API.Parameters.page)
        case .detail(let movieId):
            params.updateValue(movieId, forKey: AppConstants.API.Parameters.movieId)
        }

        return params
    }

    func asURLRequest() throws -> URLRequest {
        let url = try AppConstants.API.Host.asURL()
        var urlRequest = URLRequest(url: url)

        urlRequest.method = method

        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()

        return try encoding.encode(urlRequest, with: parameters)
    }
}
