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

            auth.runFIRCreateUser(completion: { (result) in
                switch result {

                case .Success(let user):
                    print("\(user)")
                case .Failed(let msg):
                    let alertController = UIAlertController(title: "帳號建立失敗", message: msg, preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.cancel, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                case .PasswordsNotMatch:
                    print("PasswordsNotMatch")
                }
            })

        }
        
    }

}
