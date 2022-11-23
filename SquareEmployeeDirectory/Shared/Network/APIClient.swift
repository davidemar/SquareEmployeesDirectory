//
//  API.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/22/22.
//

import Foundation

enum HTTPMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

enum HTTPScheme: String {
    case http
    case https
}

protocol API {
    var scheme: HTTPScheme { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem]? { get }
    var method: HTTPMethod { get }
}

final class APIClient {

    private class func buildURL(endpoint: API) -> URLComponents {
        var components = URLComponents()
        components.scheme = endpoint.scheme.rawValue
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        return components
    }
    
    class func request<T: Decodable>(endpoint: API,
                                     completion: @escaping (Result<T, Error>)
                                     -> Void) {
        let components = buildURL(endpoint: endpoint)
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) {
            data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard response != nil, let data = data else { return }
            do {
                let responseObject = try JSONDecoder().decode(T.self,
                                                          from: data)
                completion(.success(responseObject))
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
}
