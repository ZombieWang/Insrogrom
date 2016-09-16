//
//  Instogrom.swift
//  Instogrom
//
//  Created by PC9630 on 2016/9/12.
//  Copyright © 2016年 ZombieWang. All rights reserved.
//

import Foundation
import Firebase

//Error Type
enum RegisterError: Error {
    case passwordsNotMatch
    case duplicatedId
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

    func registerAccount() throws {
        guard password == confirmPassword else {
            throw RegisterError.passwordsNotMatch
        }
        FIRAuth.auth()?.createUser(withEmail: id, password: password, completion: { (user, error) in
            if let error = error {
                print("\(error)")
                //在這邊想判斷error的類型並throw自定的enum RegisterError該怎麼寫

            } else {
                print("Reg completed")
            }
        })
    }
    
    
}
