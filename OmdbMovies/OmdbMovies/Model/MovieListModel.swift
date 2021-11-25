//
//  Movie.swift
//  OmdbMovies
//
//  Created by LongTM3 on 11/22/21.
//

import Foundation

struct MovieListModel: Decodable {
    let title: String?
    let year: String?
    let imdbID: String?
    let type: OmdbType?
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
