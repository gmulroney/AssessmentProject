//
//  NetworkManager.swift
//  AssessmentProject
//
//  Created by Garrett Mulroney on 3/19/21.
//

import Foundation

class NetworkManager {
    static let sharedInstance = NetworkManager();
    private var baseUrl = URL(string: "https://02b2d9d2-ecf0-4f8b-924e-2b618d4de19d.mock.pstmn.io/")
    
    private init() {}
    
    func makeRequest(endPoint: String, requestMethod: String, completionBlock: @escaping (Result<Data?,Error>) -> Void) {
        guard let url = baseUrl?.appendingPathComponent(endPoint) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = requestMethod
        request.setValue("200", forHTTPHeaderField: "x-mock-response-code")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            completionBlock(.success(data))
        }.resume()
    }
}
