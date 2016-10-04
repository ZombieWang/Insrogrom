//
//  MainPageViewController.swift
//  Instogrom
//
//  Created by PC9630 on 2016/9/28.
//  Copyright © 2016年 ZombieWang. All rights reserved.
//

import UIKit
import Firebase

class MainPageViewController: UIViewController {


    @IBAction func logOutTapped(_ sender: AnyObject) {
        do { try FIRAuth.auth()?.signOut()
        } catch {
            print("Sign out failed!")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
