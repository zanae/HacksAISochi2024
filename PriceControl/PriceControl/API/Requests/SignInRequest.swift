//
//  SignInRequest.swift
//  PriceControl
//
//  Created by Матвей Кузнецов on 12.04.2024.
//

import Foundation

struct SignInRequest: APIRequest {
    typealias Response = AuthResponse
    
    var path: String { "/signup" }
    
    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "email", value: email)]
    }
    
    var email: String
}
