//
//  UserServices.swift
//  MVVM-Sample
//
//  Created by Marcos Lacerda on 31/10/18.
//  Copyright © 2018 Marcos Lacerda. All rights reserved.
//

import Foundation

class UserServices: NSObject {
    
    static let shared = UserServices()
    
    fileprivate override init() {}
    
    func login(with email: String, password: String, handler: @escaping ((Result<User>) -> Void)) {
        // fake network validation
        if email != "test@test.com" && password != "12345678909" {
            // Simulate delay to response the request
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                handler(.error("E-mail and/or password wrong"))
            }
        } else {
            let user = User(with: email)
            handler(.success(user))
        }
    }

}
