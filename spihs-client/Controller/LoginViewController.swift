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
        // Notificaton center
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"loadingDataNotification:", name: "loadingData", object: nil)
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
    
    func loadingDataNotification(notification: NSNotification) {
        /*let active = notification.userInfo!["Bool"] as! Bool
        if active == true {
            self.loadingActivityIndicator.hidden = false
            self.loadingActivityIndicator.startAnimating()
            self.view.userInteractionEnabled = false
        }
        else {
            self.loadingActivityIndicator.hidden = true
            self.loadingActivityIndicator.stopAnimating()
            self.view.userInteractionEnabled = true
        }*/
        var loadingView = LoadingView()
        self.view.addSubview(loadingView)
        loadingView.addBehaviour(self.view)
    }
}
