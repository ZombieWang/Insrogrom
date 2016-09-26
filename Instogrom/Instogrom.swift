//
//  Instogrom.swift
//  Instogrom
//
//  Created by PC9630 on 2016/9/12.
//  Copyright © 2016年 ZombieWang. All rights reserved.
//

import Foundation
import Firebase

//Auth Status & Error
enum CreateUserStatus<T> {
    case PasswordsNotMatch
    case Failed(String)
    case Success(T)
}

//Helper Class

class Auth {
    let id: String
    let password: String
    let confirmPassword: String

    init(id: String, password: String, confirmPassword: String) {
        self.id = id
        self.password = password
        self.confirmPassword = confirmPassword
    }

    func runFIRCreateUser(completion: @escaping (CreateUserStatus<FIRUser>) -> ())  {
        guard self.password == self.confirmPassword else {
            return completion(.PasswordsNotMatch)
        }

        FIRAuth.auth()?.createUser(withEmail: id, password: password, completion: { (user, error) in
            if let error = error as? NSError{
                //TODO: 處理error
               completion(.Failed(error.localizedDescription))

            } else {
                completion(.Success(user!))
            }
        })
    }
}



