//
//  OmdbAPIServices.swift
//  OmdbMovies
//
//  Created by LongTM3 on 11/23/21.
//  Copyright © 2021 LongTM3. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class OmdbApiClient {
    func request<T: Decodable> (_ router: OmdbRouter) -> Observable<T> {
        let session = Alamofire.Session.default

        return Observable<T>.create { observer in
            let request = session.request(router).validate().responseDecodable(of: T.self) { response in
                guard let data = response.value else {
                    observer.onError(OmdbApiError.error(message: "Cannot get data"))
                    return
                }

                observer.onNext(data)
                observer.onCompleted()
            }

            return Disposables.create {
                request.cancel()
            }
        }
    }
}
