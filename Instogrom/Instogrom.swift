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
enum AuthStatus<T> {
    case PasswordsNotMatch(String)
    case EmailAlreadyInUse(String)
    case WeakPassword(String)
    case InvalidEmail(String)
    case Failed(String)
    case WrongPassword(String)
    case UserNotFound(String)
    case EmptyEmailOrPassword(String)
    case Success(T)
}

//Helper Class

class Auth {
    let id: String
    let password: String
    let confirmPassword: String?

    init(id: String, password: String, confirmPassword: String?) {
        self.id = id
        self.password = password
        self.confirmPassword = confirmPassword

    }

    func createUser(completion: @escaping (AuthStatus<FIRUser>) -> ())  {
        guard self.password == self.confirmPassword else {
            return completion(.PasswordsNotMatch("兩次輸入的密碼不同！"))
        }
        guard self.password != "" && self.id != "" else {
            return completion(.EmptyEmailOrPassword("帳號與密碼不得為空！"))
        }

        FIRAuth.auth()?.createUser(withEmail: id, password: password, completion: { (user, error) in
            if let error = error as? NSError{
                switch error.code {
                    case 17007:
                        completion(.EmailAlreadyInUse("此Email已被註冊！"))
                    case 17026:
                        completion(.WeakPassword("至少輸入6個字以上密碼！"))
                    case 17008:
                        completion(.InvalidEmail("請輸入合法的Email！"))
                    default:
                        print("\(error.code)")
                        completion(.Failed(error.localizedDescription))
                }
            } else {
                completion(.Success(user!))
            }
        })
    }

    func signIn(completion: @escaping (AuthStatus<FIRUser>)->()) {
        guard self.password != "" && self.id != "" else {
            return completion(.EmptyEmailOrPassword("帳號與密碼不得為空！"))
        }

        FIRAuth.auth()?.signIn(withEmail: id, password: password, completion: { (user, error) in
            if let error = error as? NSError {
                switch error.code {
                case 17009:
                    completion(.WrongPassword("密碼錯誤!"))
                case 17011:
                    completion(.UserNotFound("此Email不存在!"))
                default:
                    print("\(error.code)")
                    completion(.Failed(error.localizedDescription))
                }
            }
        })
    }


}



