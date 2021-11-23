//
//  MovieViewModel.swift
//  OmdbMovies
//
//  Created by LongTM3 on 11/23/21.
//  Copyright © 2021 LongTM3. All rights reserved.
//

import Foundation
import RxSwift

class MovieViewModel {
    let movies: PublishSubject<[MovieListModel]> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    let error: PublishSubject<OmdbApiError> = PublishSubject()

    private var currentQuery: String = ""
    private var currentPage: Int = 0
    private let movieServices = MovieServices()

    func searchMovie(_ query: String) {
        loading.onNext(true)
        if query == currentQuery {
            currentPage = currentPage + 1
        } else {
            currentPage = 0
            currentQuery = query
        }

        movieServices.searchForMovie(query, page: currentPage).subscribe { moviesResponse in
            movies
        } onError: { <#Error#> in
            <#code#>
        }

    }
}
