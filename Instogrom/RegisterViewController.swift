//
//  RegisterViewController.swift
//  Instogrom
//
//  Created by PC9630 on 2016/9/10.
//  Copyright © 2016年 ZombieWang. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func toLoginTapped() {
       _ = self.navigationController?.popToRootViewController(animated: true)
    }


    @IBAction func registerTapped() {
        if let email = emailField.text, let password = passwordField.text, let confirmPassword = confirmPasswordField.text {
            let auth = Auth(id: email, password: password, confirmPassword: confirmPassword)

            auth.createUser(completion: { (result) in
                switch result {
                case .Success(let user):
                    print("\(user)")
                case .Failed(let msg):
                    self.showAlert(title: "帳號建立失敗", msg: msg)
                case .PasswordsNotMatch(let msg):
                    self.showAlert(title: "帳號建立失敗", msg: msg)
                case .EmailAlreadyInUse(let msg):
                    self.showAlert(title: "帳號建立失敗", msg: msg)
                case .WeakPassword(let msg):
                    self.showAlert(title: "密碼強度太低", msg: msg)
                case .InvalidEmail(let msg):
                    self.showAlert(title: "帳號建立失敗", msg: msg)
                case .EmptyEmailOrPassword(let msg):
                    self.showAlert(title: "請輸入完整帳戶資訊", msg: msg)
                default:
                    self.showAlert(title: "發生錯誤", msg: "未預期錯誤！")
                }
            })

        }
        
    }
    
     func showAlert(title: String, msg: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

}
