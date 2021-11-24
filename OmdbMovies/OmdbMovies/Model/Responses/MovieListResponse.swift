//
//  MovieListResponse.swift
//  OmdbMovies
//
//  Created by LongTM3 on 11/22/21.
//

import Foundation

struct MovieListResponse: Decodable {
    var search: [MovieListModel]?
    var totalResults: Int?
    var response: Bool
    var error: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
        case error = "Error"
    }

    init(from decoder: Decoder) throws {
        let data = try decoder.container(keyedBy: CodingKeys.self)

        if let totalResultsString = try? data.decode(String.self, forKey: CodingKeys.totalResults) {
            search = try data.decode([MovieListModel].self, forKey: CodingKeys.search)
            totalResults = Int(totalResultsString)
        }

        let responseString = try data.decode(String.self, forKey: CodingKeys.response)
        response = responseString.boolValue
        error = try? data.decode(String.self, forKey: CodingKeys.error)
    }
}
