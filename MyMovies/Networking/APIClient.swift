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
    
    /**
     Function to send a request to an API endpoint and decode the response into a provided Decodable type.
     
     - Parameter endpoint: An instance of `APIEndpoint` containing the required information to build the request.
     - Returns: An `Observable` containing the decoded response object of type `T` or an error.
     */
    func request<T: Decodable>(endpoint: APIEndpoint) -> Observable<T> {
        // Construct the full URL by appending the endpoint path to the base URL
        let url = baseURL + endpoint.path
        return Observable<T>.create { observer in
            // Create and configure the request using Alamofire with the provided endpoint information
            let request = AF.request(url, method: endpoint.method, parameters: endpoint.parameters, headers: endpoint.headers)
                .validate()
                .responseDecodable(of: T.self) { response in
                    // Process the response by checking the result
                    switch response.result {
                    case .success(let value):
                        // If successful, emit the decoded value and complete the observer
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        // If there's an error, emit the error
                        observer.onError(error)
                    }
                }

            // Return a disposable that cancels the request when the observable is disposed
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

