//
//  ConfirmationCodeRequest.swift
//  PriceControl
//
//  Created by Матвей Кузнецов on 12.04.2024.
//

import Foundation

struct ConfirmationCodeRequest: APIRequest {
    typealias Response = AuthConfirmationResponse
    
    var path: String { "/confirm" }
    
    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "email", value: email),
         URLQueryItem(name: "confirmationCode", value: confirmationCode)]
    }
    
    var email: String
    var confirmationCode: String
}
