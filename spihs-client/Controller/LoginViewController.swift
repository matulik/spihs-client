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
    var loadingView : LoadingView = LoadingView()
    
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
    
//    @IBAction func logoutBarButton(sender: AnyObject) {
//        self.login.logout()
//    }
    
    // "loging", "ok", "failed"
    func loadingDataNotification(notification: NSNotification) {
        let result = notification.userInfo!["Result"] as! String
        if result == "loging" {
            self.loadingView.startLoading(self.view)
            self.view.userInteractionEnabled = false
        }
        else if result == "failed" {
            self.loadingView.stopLoading()
            self.view.userInteractionEnabled = true
        }
        
        else if result == "ok" {
            self.loadingView.stopLoading()
            self.view.userInteractionEnabled = true
            var next = self.storyboard?.instantiateViewControllerWithIdentifier("AfterLoginNavigationController") as! UINavigationController
            self.presentViewController(next, animated: true, completion: nil)
        }
    }
}
