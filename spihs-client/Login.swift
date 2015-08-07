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
let fjson = "?format=json"
// Must be implementet of all Request-base classes
let numberOfCallbacks = 2

class Login : Request {
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
    
    // ID = 1
    func login() {
        let parameters = [
            "username": self.username,
            "password": self.password
        ]
        // Send notification to ViewController
        self.notificationDictonary["Bool"] = true
        NSNotificationCenter.defaultCenter().postNotificationName("loadingData", object: nil, userInfo: self.notificationDictonary)
        self.sendRequest("POST", subpage: "login/", returnType: "JSON", params: parameters, callbackID: 1, loging: true)
    }
    
    // ID = 1
    func loginCallback(status: Int, data: AnyObject) {
        if status != 200 {
            println("Bad status code")
            return
        }
        // Send notification to ViewController
        self.notificationDictonary["Bool"] = false
        NSNotificationCenter.defaultCenter().postNotificationName("loadingData", object: nil, userInfo: self.notificationDictonary)
        
        if let t = JSON(data)["token"].string {
            self.token = t
        }
        else {
            println("Response doesnt return token")
        }
    }
    
    // ID = 2
    func logout() {
        self.sendRequest("GET", subpage: "logout/", returnType: "JSON", params: ["":""], callbackID: 2, loging: true)
    }
}













