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

    func runFIRCreateUser(complete: @escaping (FIRUser?, Error?) -> Void) {
        FIRAuth.auth()?.createUser(withEmail: id, password: password, completion: { (user, error) in
            if let error = error {
                print("\(error)")
                //在這邊想判斷error的類型並throw自定的enum RegisterError該怎麼寫
                complete(nil, error)
            } else {
                complete(user, nil)
            }
        })
    }

    func registerAccount() throws {
        guard password == confirmPassword else {
            throw RegisterError.passwordsNotMatch
        }
        runFIRCreateUser { (user, error) in
            guard error != nil {
                throw RegisterError.duplicatedId
            } else {

            }
        }

//        func runAuth  //FIRUser?  Error?



        func createUser() {
            runFIRCreateUser(complete: <#T##(FIRUser?, Error?) -> Void#>)
        }
    }


}
