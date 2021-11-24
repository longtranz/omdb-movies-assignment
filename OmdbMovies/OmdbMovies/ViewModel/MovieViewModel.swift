//
//  MovieViewModel.swift
//  OmdbMovies
//
//  Created by LongTM3 on 11/23/21.
//  Copyright © 2021 LongTM3. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class MovieViewModel {
    let movies: PublishSubject<[MovieListModel]> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    let error: PublishSubject<Error> = PublishSubject()

    private var currentQuery = BehaviorRelay(value: "Marvel")
    private var currentPage: Int = 0
    private let movieServices = MovieServices()

    func searchMovie(_ query: String) {
        loading.onNext(true)
        if query == currentQuery.value {
            currentPage = currentPage + 1
        } else {
            currentPage = 0
        }

        movieServices.searchForMovie(query, page: currentPage).subscribe { moviesResponse in

        } onError: { [weak self] e in
            self?.error.onNext(e)
        }
    }
}
