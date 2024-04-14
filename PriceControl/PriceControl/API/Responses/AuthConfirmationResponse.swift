//
//  AuthConfirmationResponse.swift
//  PriceControl
//
//  Created by Матвей Кузнецов on 12.04.2024.
//

import Foundation

struct AuthConfirmationResponse {
    var confirmationModel: AuthConfirmationModel
}

extension AuthConfirmationResponse: Decodable {
    public enum CodingKeys: String, CodingKey {
        case confirmationModel = "response"
    }
}
