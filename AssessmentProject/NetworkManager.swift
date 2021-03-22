//
//  NetworkManager.swift
//  AssessmentProject
//
//  Created by Garrett Mulroney on 3/19/21.
//

import Foundation

enum NetworkError : Error {
    case badRequestError
    case notFoundError
    case badResponseError
    case connectionError
    case unknownError
}

class NetworkManager {
    static let sharedInstance = NetworkManager();
    private var baseUrl = URL(string: "https://02b2d9d2-ecf0-4f8b-924e-2b618d4de19d.mock.pstmn.io/")
    
    private init() {}
    
    func makeRequest(endPoint: String, requestMethod: String, completionBlock: @escaping (Result<Data?,NetworkError>) -> Void) {
        guard let url = baseUrl?.appendingPathComponent(endPoint) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = requestMethod
        request.setValue("400", forHTTPHeaderField: "x-mock-response-code")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                completionBlock(.failure(.connectionError))
                return
            }
            let response = response as? HTTPURLResponse
            if response?.statusCode == 200 {
                completionBlock(.success(data))
            } else {
                completionBlock(.failure(response?.statusCode == 400 ? .badRequestError : .notFoundError))
            }
        }.resume()
    }
}
