//
//  OmdbResponseModel.swift
//  OmdbMovies
//
//  Created by LongTM3 on 11/22/21.
//

import Foundation

struct OmdbResponseModel: Decodable {
    let search: [MovieListModel]
    let totalResults: String
    let response: String
    let error: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
        case error = "Error"
    }
}
