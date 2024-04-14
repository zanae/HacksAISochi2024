//
//  APIRequestProtocol.swift
//  PriceControl
//
//  Created by Матвей Кузнецов on 12.04.2024.
//

import UIKit

public protocol APIRequest {
    associatedtype Response
    
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var request: URLRequest { get }
}

extension APIRequest {
    public var host: String { "www.pricecontrol.dnr" }
}

extension APIRequest {
    public var queryItems: [URLQueryItem]? { nil }
}

extension APIRequest {
    public var request: URLRequest {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = host
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            fatalError("Failed to create URL for URLRequest")
        }
        
        return URLRequest(url: url)
    }
}

extension APIRequest where Response: Decodable {
    public func send(completion: @escaping (Result<Response, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}

