//
//  SignUpRequest.swift
//  PriceControl
//
//  Created by Матвей Кузнецов on 12.04.2024.
//

import Foundation

struct SignUpRequest: APIRequest {
    typealias Response = AuthResponse
    
    var path: String { "/signup" }
    
    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "email", value: email),
         URLQueryItem(name: "phone", value: phoneNumber)]
    }
    
    var email: String
    var phoneNumber: String
}
