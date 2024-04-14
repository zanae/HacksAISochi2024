//
//  AuthService.swift
//  PriceControl
//
//  Created by Матвей Кузнецов on 12.04.2024.
//

import Foundation

class AuthService {
    typealias AuthToken = String
    
    private enum Constants {
        static let tokenKey = "token"
        static let userTypeKey = "userType"
        
    }
    
    static let shared = AuthService()
    
    private init() { }
    
    func signIn(
        email: String,
        _ completion: @escaping (AuthError?) -> Void
    ) {
        let request = SignInRequest(email: email)
        request.send { result in
            if case let .success(response) = result {
                if response.responseModel.success {
                    completion(nil)
                } else if let serverErrorText = response.responseModel.error {
                    completion(.serverError(text: serverErrorText))
                }
            } else {
                completion(.networkError)
            }
        }
    }
    
    func signUp(
        email: String,
        phoneNumber: String,
        _ completion: @escaping (AuthError?) -> Void
    ) {
        let request = SignUpRequest(email: email, phoneNumber: phoneNumber)
        request.send { result in
            if case let .success(response) = result {
                if response.responseModel.success {
                    completion(nil)
                } else if let serverErrorText = response.responseModel.error {
                    completion(.serverError(text: serverErrorText))
                } else {
                    completion(.networkError)
                }
            } else {
                completion(.networkError)
            }
        }
    }
    
    func submitConfirmationCode(
        email: String,
        code: String,
        _ completion: @escaping (Result<AuthToken, AuthError>) -> Void
    )  {
        let request = ConfirmationCodeRequest(email: email, confirmationCode: code)
        request.send { result in
            if case let .success(response) = result {
                if response.confirmationModel.success,
                   let token = response.confirmationModel.token,
                   let userType = response.confirmationModel.userType {
                    self.saveData(token: token, userType: userType)
                    completion(.success(token))
                } else if let serverErrorText = response.confirmationModel.error {
                    completion(.failure(.serverError(text: serverErrorText)))
                } else {
                    completion(.failure(.networkError))
                }
            } else {
                completion(.failure(.networkError))
            }
        }
    }
    
    func saveData(token: String, userType: String) {
        UserDefaults.standard.set(token, forKey: Constants.tokenKey)
        UserDefaults.standard.set(userType, forKey: Constants.userTypeKey)
        
    }
    
    func getAuthenticatedUserType() -> String? {
        guard UserDefaults.standard.string(forKey: Constants.tokenKey) != nil,
              let userType = UserDefaults.standard.string(forKey: Constants.userTypeKey),
              !userType.isEmpty else {
            return nil
        }
        return userType
    }
}
