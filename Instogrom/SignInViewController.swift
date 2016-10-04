//
//  SignUpViewController.swift
//  Instogrom
//
//  Created by PC9630 on 2016/9/4.
//  Copyright © 2016年 ZombieWang. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!

    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signInTapped(_ sender: AnyObject) {
        if let email = emailField.text, let password = passwordField.text {
            let auth = Auth(id: email, password: password, confirmPassword: nil)
            auth.signIn(completion: { (result) in
                switch result {
                case .WrongPassword(let msg):
                    self.showAlert(title: "密碼錯誤", msg: msg)
                case .UserNotFound(let msg):
                    self.showAlert(title: "此帳號不存在", msg: msg)
                case .Failed(let msg):
                    self.showAlert(title: "登入失敗", msg: msg)
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
