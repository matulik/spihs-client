//
//  Login.swift
//  spihs-client
//
//  Created by CS_praktykant on 06/08/15.
//  Copyright (c) 2015 mt. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let host = "http://127.0.0.1:8000/"

// Must be implementet of all Request-base classes
let numberOfCallbacks = 2

class Login : Request {
    
    // Singleton
    static let sharedInstance = Login()
    //
    
    var id : Int = -1
    var username : String = ""
    var password : String = ""
    var email : String = ""
    var status : Int = 0
    var token : String = ""
    var notificationDictonary = ["Result": ""]
    
    override init() {
        // TODO INITIALIZATION
    }
    
    // Callback methods
    override func callback(id: Int, status: Int, data: AnyObject) {
        if id == 1 {
            self.loginCallBack(status, data: data)
        }
        if id == 2 {
            self.logoutCallBack(status, data: data)
        }
    }
    
    // ID = 1, REQUEST
    func login() {
        let parameters = [
            "username": Login.sharedInstance.username,
            "password": Login.sharedInstance.username
        ]
        Login.sharedInstance.notificationDictonary["Result"] = "loging"
        self.sendNotification("loginViewControllerObserver", userInfo: Login.sharedInstance.notificationDictonary)
        self.sendRequest("POST", subpage: "login/", returnType: "JSON", params: parameters, callbackID: 1, loging: true)
    }
    
    // ID = 1, REPSONSE
    func loginCallBack(status: Int, data: AnyObject) {
        if status != 200 {
            println("Bad status code")
            // TODO
        }

        if let t = JSON(data)["token"].string {
            Login.sharedInstance.token = t
            Login.sharedInstance.notificationDictonary["Result"] = "ok"
        }
        else {
            println("Response doesnt return token")
            Login.sharedInstance.notificationDictonary["Result"] = "failed"
        }
        self.sendNotification("loginViewControllerObserver", userInfo: Login.sharedInstance.notificationDictonary)
    }
    
    // ID = 2, REQUEST
    func logout() {
        self.sendRequest("GET", subpage: "logout/", returnType: "JSON", params: ["":""], callbackID: 2, loging: true)
        Login.sharedInstance.notificationDictonary["Result"] = "logout"
        self.sendNotification("loginViewControllerObserver", userInfo: Login.sharedInstance.notificationDictonary)
    }
    
    // ID = 2, RESPONSE
    func logoutCallBack(status: Int, data: AnyObject) {
        if status != 200 {
            Login.sharedInstance.notificationDictonary["Result"] = "failed"
        }
        else {
            Login.sharedInstance.notificationDictonary["Result"] = "ok"
        }
        self.sendNotification("loginViewControllerObserver", userInfo: Login.sharedInstance.notificationDictonary)
    }
}