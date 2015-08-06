//
//  LoginViewController.swift
//  spihs-client
//
//  Created by CS_praktykant on 06/08/15.
//  Copyright (c) 2015 mt. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var login : Login = Login()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginButton(sender: AnyObject) {
        self.login.username = self.loginTextField.text
        self.login.password = self.passwordTextField.text
        self.login.login()
    }
    
    @IBAction func logoutBarButton(sender: AnyObject) {
        self.login.logout()
    }
}
