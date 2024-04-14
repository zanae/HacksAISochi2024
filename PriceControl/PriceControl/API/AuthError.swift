//
//  SignInError.swift
//  PriceControl
//
//  Created by Матвей Кузнецов on 12.04.2024.
//

import Foundation

enum AuthError: Error {
    case networkError
    case serverError(text: String)
}
