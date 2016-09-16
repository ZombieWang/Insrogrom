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
        self.navigationController?.popViewController(animated: true)
    }


    @IBAction func registerTapped() {
        if let email = emailField.text, let password = passwordField.text, let confirmPassword = confirmPasswordField.text {
            let auth = Auth(id: email, password: password, confirmPassword: confirmPassword)

            do {
                try auth.registerAccount()
                //TODO: change page
            } catch RegisterError.passwordsNotMatch {
                print("dont match pw")
            }
            catch RegisterError.duplicatedId{
                
            } catch {
                fatalError("fatalError")
            }

        }
        
    }

}
