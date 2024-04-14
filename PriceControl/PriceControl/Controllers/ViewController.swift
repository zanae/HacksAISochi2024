//
//  ViewController.swift
//  PriceControl
//
//  Created by Матвей Кузнецов on 12.04.2024.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {
    
    
//    lazy var claimsNavigationController = {
//        let claimsController = ClaimsController()
//        let navigationController = UINavigationController(rootViewController: claimsController)
//        return navigationController
//    }()
    
    
    lazy var authNavigationController = {
        
        let authController = AuthController()
        let navigationController = UINavigationController(rootViewController: authController)
        navigationController.modalPresentationStyle = .fullScreen
        
        authController.onSuccessfulLogin = { [weak self] in
            guard let self else { return }
            self.dismiss(animated: true)
//            let userType = AuthService.shared.getAuthenticatedUserType()
//            if userType == "seller" {
//                present(self.claimsNavigationController, animated: false)
//            }
        }
        return navigationController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let userType = AuthService.shared.getAuthenticatedUserType()
        if userType == nil {
            present(authNavigationController, animated: false)
        }
//        } else if userType == "seller" {
//            present(claimsNavigationController, animated: false)
//        }
        
//        let configuration = PHPickerConfiguration(photoLibrary: .shared())
//        
//        let picker = PHPickerViewController(configuration: configuration)
//        picker.delegate = self
//        present(picker, animated: true)
    }


}

