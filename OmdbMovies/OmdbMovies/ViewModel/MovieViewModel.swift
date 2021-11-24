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
import UIKit

class MovieViewModel {
    let movies: PublishSubject<[MovieListModel]> = PublishSubject()
    let loading: PublishRelay<Bool> = PublishRelay()
    let error: PublishSubject<Error> = PublishSubject()

    var currentQuery: BehaviorRelay<String> = BehaviorRelay(value: "Marvel")
    var currentPage: BehaviorRelay<Int> = BehaviorRelay(value: 1)

    private let movieServices = MovieServices()
    private let disposeBag = DisposeBag()

    init() {
        currentQuery.subscribe(onNext: { [weak self] query in
            guard let strongSelf = self else { return }
            strongSelf.searchMovie(query)
        }).disposed(by: disposeBag)
    }

    private func searchMovie(_ query: String) {
        loading.accept(true)

        movieServices.searchForMovie(query, page: currentPage.value)
            .subscribe( onNext: { [weak self] moviesResponse in
            self?.loading.accept(false)
            if let movies = moviesResponse.search {
                self?.movies.onNext(movies)
            }
        }, onError: { [weak self] e in
            self?.error.onNext(e)
        }).disposed(by: disposeBag)
    }
}
