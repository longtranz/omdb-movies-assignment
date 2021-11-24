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
    static func request<T: Decodable> (_ router: OmdbRouter, onCompletion: @escaping (T) -> Void, onError: @escaping (OmdbApiError) -> Void) {
        let session = Alamofire.Session.default

//        session.request(router).validate().responseDecodable(of: T.self) { response in
//            guard let data = response.value else {
//                onError(OmdbApiError.error(message: "Cannot get data"))
//                return
//            }
//
//            onCompletion(data)
//        }

        session.request(router).validate().responseJSON { response in
            guard let data = response.data else {
                onError(OmdbApiError.error(message: "Cannot get data"))
                return
            }

            do {
                let value = try JSONDecoder().decode(T.self, from: data)
                onCompletion(value)
            } catch {
                print(error)
                onError(OmdbApiError.error(message: "Cannot parse data"))
            }
        }

    }
}
