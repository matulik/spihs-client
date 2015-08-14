//
//  TestViewController.swift
//  spihs-client
//
//  Created by CS_praktykant on 14/08/15.
//  Copyright (c) 2015 mt. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    var loadingView = LoadingView()
    
    override func viewDidLoad() {
        // Notificaton center
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"loadingDataNotification:", name: "loadingData", object: nil)
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutBarButton(sender: AnyObject) {
        var login : Login = Login()
        println("token:\(login.token)")
        login.logout()
    }
    
    func loadingDataNotification(notification: NSNotification) {
        let result = notification.userInfo!["Result"] as! String
        if result == "logout" {
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
            var loginVC = self.storyboard?.instantiateViewControllerWithIdentifier("LoginView") as! LoginViewController
            self.presentViewController(loginVC, animated: true, completion: nil)
        }
    }
}
