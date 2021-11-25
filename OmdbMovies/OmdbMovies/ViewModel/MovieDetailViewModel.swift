//
//  MovieDetailViewModel.swift
//  OmdbMovies
//
//  Created by LongTM3 on 11/25/21.
//  Copyright © 2021 LongTM3. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetailViewModel {
    let movie: PublishSubject<MovieModel> = PublishSubject()
    let loading: PublishRelay<Bool> = PublishRelay()
    let error: PublishSubject<Error> = PublishSubject()

    private let movieServices = MovieServices()
    private let disposeBag = DisposeBag()

    func fetchMovie(_ movieId: String){
        loading.accept(true)

        movieServices.movieDetail(movieId).observe(on: MainScheduler.instance).subscribe(onNext: { [unowned self] result in
            self.loading.accept(false)
            if let movieData = try? JSONEncoder().encode(result), let movieModel = try? JSONDecoder().decode(MovieModel.self, from: movieData) {
                self.movie.onNext(movieModel)
            }
        }, onError: { [unowned self] e in
            self.error.onNext(e)
        }).disposed(by: disposeBag)
    }
}
