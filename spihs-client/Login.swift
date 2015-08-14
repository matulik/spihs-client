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
//    //Singleton
//    static let sharedInstance = Login()
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
            self.loginCallback(status, data: data)
        }
        
        if id == 2 {
            self.logoutCallback(status, data: data)
        }
    }
    
    // ID = 1, REQUEST
    func login() {
        let parameters = [
            "username": self.username,
            "password": self.password
        ]
        // Send notification to ViewController
        self.notificationDictonary["Result"] = "loging"
        NSNotificationCenter.defaultCenter().postNotificationName("loadingData", object: nil, userInfo: self.notificationDictonary)
        self.sendRequest("POST", subpage: "login/", returnType: "JSON", params: parameters, callbackID: 1, loging: true)
    }
    
    // ID = 1, REPSONSE
    func loginCallback(status: Int, data: AnyObject) {
        if status != 200 {
            println("Bad status code")
            // TODO
        }
        if let t = JSON(data)["token"].string {
            self.token = t
            self.notificationDictonary["Result"] = "ok"
        }
        else {
            println("Response doesnt return token")
            self.notificationDictonary["Result"] = "failed"
        }
        
        // Send notification to ViewController
        NSNotificationCenter.defaultCenter().postNotificationName("loadingData", object: nil, userInfo: self.notificationDictonary)
        
    }
    
    // ID = 2, REQUEST
    func logout() {
        self.sendRequest("GET", subpage: "logout/", returnType: "JSON", params: ["":""], callbackID: 2, loging: true)
        self.notificationDictonary["Result"] = "logout"
        NSNotificationCenter.defaultCenter().postNotificationName("loadingData", object: nil, userInfo: self.notificationDictonary)
    }
    
    
    // ID = 2, RESPONSE
    func logoutCallback(status: Int, data: AnyObject) {
        if status != 200 {
            println("Bad status code")
            // TODO
            self.notificationDictonary["Result"] = "failed"
        }
        else {
            self.notificationDictonary["Result"] = "ok"
        }
        NSNotificationCenter.defaultCenter().postNotificationName("loadingData", object: nil, userInfo: self.notificationDictonary)
    }
}













