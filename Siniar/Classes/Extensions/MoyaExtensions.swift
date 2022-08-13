//
//  MoyaExtensions.swift
//  Siniar
//
//  Created by Bayu Yasaputro on 13/08/22.
//

import Foundation
import Moya
import RxSwift

extension PrimitiveSequence where Trait == SingleTrait, Element == Moya.Response {
    func validate() -> Single<Response> {
        return self.flatMap { (response) -> Single<Response> in
            guard 200...299 ~= response.statusCode else {
                let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: response.data)
                if let message = errorResponse?.errorMessage,
                    !message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    let error = NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: message])
                    return Single.error(error)
                }
                else {
                    let error = NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: "Oops! Something went wrong"])
                    return Single.error(error)
                }
            }
            return Single.just(response)
        }
    }
}
