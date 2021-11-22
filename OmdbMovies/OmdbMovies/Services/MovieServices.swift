//
//  MovieServices.swift
//  OmdbMovies
//
//  Created by LongTM3 on 11/22/21.
//

import Foundation

protocol MovieServicesProtocol {
    func searchForMovie(_ s: String, page: Int?) -> [MovieListModel]?
    func movieDetail(_ movieId: String) -> MovieModel?
}

class MovieServices: MovieServicesProtocol {
    public func searchForMovie(_ s: String, page: Int?) -> [MovieListModel]? {
        return []
    }

    public func movieDetail(_ movieId: String) -> MovieModel? {
        return nil
    }
}
