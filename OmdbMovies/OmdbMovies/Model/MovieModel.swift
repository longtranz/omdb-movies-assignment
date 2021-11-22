//
//  Movie.swift
//  OmdbMovies
//
//  Created by DucNT65.FIN on 11/22/21.
//

import Foundation

enum OmdbType: String, Codable {
    case movie
}

struct MovieModel: Decodable {
    let title: String
    let year: String
    let imdbID: String
    let type: OmdbType
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
