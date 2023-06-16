//
//  APIClient.swift
//  MyMovies
//
//  Created by Karim Amsha on 16.06.2023.
//

import Alamofire
import RxSwift

class APIClient {
    static let shared = APIClient()
    private let baseURL = Constants.baseURL
    
    func request<T: Decodable>(endpoint: APIEndpoint) -> Observable<T> {
        let url = baseURL + endpoint.path
        
        return Observable<T>.create { observer in
            let request = AF.request(url, method: endpoint.method, parameters: endpoint.parameters, headers: endpoint.headers)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

