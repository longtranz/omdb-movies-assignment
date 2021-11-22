//
//  RatingModel.swift
//  OmdbMovies
//
//  Created by LongTM3 on 11/22/21.
//

import Foundation

struct RatingModel: Codable {
    let source: String
    let value: String

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}
