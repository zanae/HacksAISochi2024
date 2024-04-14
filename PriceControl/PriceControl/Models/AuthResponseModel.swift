//
//  AuthResponseModel.swift
//  PriceControl
//
//  Created by Матвей Кузнецов on 12.04.2024.
//

import Foundation

struct AuthResponseModel {
    let success: Bool
    let error: String?
}

extension AuthResponseModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case success
        case error
    }
}
