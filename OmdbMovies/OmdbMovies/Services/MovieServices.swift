//
//  MovieServices.swift
//  OmdbMovies
//
//  Created by LongTM3 on 11/22/21.
//

import Foundation
import RxSwift

protocol MovieServicesProtocol {
    func searchForMovie(_ s: String, page: Int?) -> Observable<MovieListResponse>
    func movieDetail(_ movieId: String) -> Observable<MovieResponse>
}

class MovieServices: MovieServicesProtocol {
    let disposeBag = DisposeBag()

    public func searchForMovie(_ query: String, page: Int?) -> Observable<MovieListResponse> {
        return Observable<MovieListResponse>.create { observer in
            OmdbApiClient.request(OmdbRouter.search(query: query, page: page)) { (moviesResponse: MovieListResponse) in
                if !moviesResponse.response {
                    observer.onError(OmdbApiError.error(message: moviesResponse.error ?? "API Error"))
                }

                observer.onNext(moviesResponse)
            } onError: { error in
                observer.onError(error)
            }

            return Disposables.create()
        }
    }

    public func movieDetail(_ movieId: String) -> Observable<MovieResponse> {
        return Observable<MovieResponse>.create { observer in
            OmdbApiClient.request(OmdbRouter.detail(movieId: movieId)) { (movieResponse: MovieResponse) in
                if let success = movieResponse.response?.boolValue, !success {
                    observer.onError(OmdbApiError.error(message: movieResponse.error ?? "API Error"))
                }

                observer.onNext(movieResponse)
            } onError: { error in
                observer.onError(error)
            }

            return Disposables.create()
        }
    }
}
