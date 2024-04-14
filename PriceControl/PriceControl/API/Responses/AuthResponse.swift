//
//  SignInResponse.swift
//  PriceControl
//
//  Created by Матвей Кузнецов on 12.04.2024.
//

import Foundation

struct AuthResponse {
    var responseModel: AuthResponseModel
}

extension AuthResponse: Decodable {
    public enum CodingKeys: String, CodingKey {
        case responseModel = "response"
    }
}
