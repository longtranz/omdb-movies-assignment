//
//  MovieServices.swift
//  OmdbMovies
//
//  Created by LongTM3 on 11/22/21.
//

import Foundation
import RxSwift

protocol MovieServicesProtocol {
    func searchForMovie(_ s: String, page: Int?) -> Observable<[MovieListModel]?>
    func movieDetail(_ movieId: String) -> Observable<MovieResponse?>
}

class MovieServices: MovieServicesProtocol {
    private let omdbClient = OmdbApiClient()

    public func searchForMovie(_ s: String, page: Int?) -> Observable<[MovieListModel]?> {
        omdbClient.request(OmdbRouter.search(query: s, page: page ?? 0)).observe(on: MainScheduler.instance).subscribe { movieListResponse in

        } onError: { <#Error#> in
            <#code#>
        }

    }

    public func movieDetail(_ movieId: String) -> Observable<MovieResponse?> {
        return Observable.just(nil)
    }
}
