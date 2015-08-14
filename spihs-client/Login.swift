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
    var notificationDictonary = ["Bool": false]
    
    override init() {
        // TODO INITIALIZATION
    }
    
    // Callback methods
    override func callback(id: Int, status: Int, data: AnyObject) {
        if id == 1 {
            self.loginCallback(status, data: data)
        }
    }
    
    // ID = 1, REQUEST
    func login() {
        let parameters = [
            "username": Login.sharedInstance.username,
            "password": Login.sharedInstance.username
        ]
        // Send notification to ViewController
        Login.sharedInstance.notificationDictonary["Bool"] = true
        NSNotificationCenter.defaultCenter().postNotificationName("loadingData", object: nil, userInfo: Login.sharedInstance.notificationDictonary)
        self.sendRequest("POST", subpage: "login/", returnType: "JSON", params: parameters, callbackID: 1, loging: true)
    }
    
    // ID = 1, REPSONSE
    func loginCallback(status: Int, data: AnyObject) {
        if status != 200 {
            println("Bad status code")
            // TODO
        }
        // Send notification to ViewController
        Login.sharedInstance.notificationDictonary["Bool"] = false
        NSNotificationCenter.defaultCenter().postNotificationName("loadingData", object: nil, userInfo: Login.sharedInstance.notificationDictonary)
        
        if let t = JSON(data)["token"].string {
            Login.sharedInstance.token = t
        }
        else {
            println("Response doesnt return token")
        }
    }
    
    // ID = 2, REQUEST
    func logout() {
        self.sendRequest("GET", subpage: "logout/", returnType: "JSON", params: ["":""], callbackID: 2, loging: true)
    }
}