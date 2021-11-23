//
//  Constants.swift
//  OmdbMovies
//
//  Created by LongTM3 on 11/22/21.
//  Copyright © 2021 LongTM3. All rights reserved.
//

import Foundation

struct AppConstants {
    struct API {
        struct Parameters {
            static let apiKey = "apikey"
            static let searchQuery = "s"
            static let movieId = "i"
            static let type = "type"
            static let page = "page"
        }

        static var APIKey = ""
        static let Host = "http://www.omdbapi.com"
    }
}
