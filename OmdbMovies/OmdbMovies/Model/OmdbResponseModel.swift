//
//  OmdbResponseModel.swift
//  OmdbMovies
//
//  Created by DucNT65.FIN on 11/22/21.
//

import Foundation

struct OmdbResponseModel: Decodable {
    let search: [MovieModel]
    let totalResults: String
    let response: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}
