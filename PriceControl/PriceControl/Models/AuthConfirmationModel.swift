//
//  AuthConfirmationModel.swift
//  PriceControl
//
//  Created by Матвей Кузнецов on 12.04.2024.
//

import Foundation

struct AuthConfirmationModel {
    let success: Bool
    let token: String?
    let userType: String?
    let error: String?
   
}

extension AuthConfirmationModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case success
        case token
        case userType
        case error
    }
}
