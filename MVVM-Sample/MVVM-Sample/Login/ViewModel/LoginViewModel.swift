//
//  LoginViewModel.swift
//  MVVM-Sample
//
//  Created by Marcos Lacerda on 31/10/18.
//  Copyright © 2018 Marcos Lacerda. All rights reserved.
//

struct LoginViewModel {
    let delegate: LoginDelegate!
    
    init(with listener: LoginDelegate) {
        self.delegate = listener
    }
    
    func login(with email: String, password: String) {
        // Validate data
        if email.isEmpty {
            self.delegate.loginError("E-mail wrong")
            return
        }
        
        if password.isEmpty {
            self.delegate.loginError("Password wrong")
            return
        }
        
        UserServices.shared.login(with: email, password: password) { result in
            switch result {
            case .success(let user):
                self.delegate.loginSuccess(user)
                
                break
                
            case .error(let error):
                self.delegate.loginError(error)
                break
                
            }
        }
    }
    
}
