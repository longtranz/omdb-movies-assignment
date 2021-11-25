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
    let movies: BehaviorRelay<[MovieListModel]> = BehaviorRelay(value: [])
    let loading: PublishRelay<Bool> = PublishRelay()
    let error: PublishSubject<Error> = PublishSubject()

    var currentQuery: BehaviorRelay<String> = BehaviorRelay(value: "Marvel")
    var fetchMoreData: PublishSubject<Void> = PublishSubject()

    var currentPage = 1

    private let movieServices = MovieServices()
    private let disposeBag = DisposeBag()

    func bindView() {
        currentQuery.distinctUntilChanged().filter({!$0.isEmpty}).subscribe(onNext: { [weak self] query in
            guard let strongSelf = self else { return }
            strongSelf.currentPage = 1
            strongSelf.movies.accept([])
            strongSelf.searchMovie(query)
        }).disposed(by: disposeBag)
    }

    private func searchMovie(_ query: String) {
        loading.accept(true)

        movieServices.searchForMovie(query, page: currentPage)
            .observe(on: MainScheduler.instance)
            .subscribe( onNext: { [weak self] moviesResponse in
                guard let strongSelf = self else { return }
                strongSelf.loading.accept(false)
                if let movies = moviesResponse.search {
                    let oldMovieData = strongSelf.movies.value
                    strongSelf.movies.accept(oldMovieData + movies)
                }
        }, onError: { [weak self] e in
            self?.error.onNext(e)
        }).disposed(by: disposeBag)
    }
}
