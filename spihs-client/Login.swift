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
let numberOfCallbacks = 2

class Login {
    var id : Int = -1
    var username : String = ""
    var password : String = ""
    var email : String = ""
    var status : Int = 0
    var token : String = ""
    var notificationDictonary = ["Bool": false]
    
    init() {
        //        TODO INITIALIZATION
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
        self.sendRequest("GET", subpage: "logout/", returnType: "DEFAULT", params: ["":""], callbackID: 2, loging: true)
    }
    
    // parametrers:
    // methos: GET, POST
    // returnType: JSON, DEFAULT
    func sendRequest(method : String, subpage : String, returnType: String, params : [String:String], callbackID: Int, loging: Bool) {
        // Validate method
        var method = method.uppercaseString
        if (method != "GET" && method != "POST") {
            println("Bad method value")
            return
        }
        // Validete returnType
        var returnType = returnType.uppercaseString
        if (returnType != "JSON" && returnType != "DEFAULT") {
            println("Bad returnType value")
            return
        }
        
        if (callbackID < 0 || callbackID > numberOfCallbacks) {
            println("Bad callback value")
            return
        }
        
        var httpMethod : Alamofire.Method?
        if method == "GET" {
            httpMethod = Alamofire.Method.GET
        }
        else if method == "POST" {
            httpMethod = Alamofire.Method.POST
        }
        else {
            httpMethod = nil
        }
        
        switch(returnType) {
        case "DEFAULT":
            Alamofire.request(httpMethod!, host+subpage, parameters: params)
                .response { request, response, data ,error in
                    var statusCode : Int = 0
                    if loging == true {
                        println("### SENDING ###")
                        println("➡️Request: \(method) on \(subpage) with \(params)\n")
                        if let resp = response {
                            statusCode = resp.statusCode
                            println("⬅️statusCode: \(statusCode)")
                            println("🔤Response: \(data)")
                        }
                        else {
                            statusCode = 0
                            println("⛔️\(error)")
                        }
                    }
                    if let ldata: AnyObject = data {
                        self.callback(callbackID, status: statusCode, data: ldata)
                    }
                    else {
                        self.callback(callbackID, status: statusCode, data: 0)
                    }
            }
            
        case "JSON":
            Alamofire.request(httpMethod!, host+subpage+fjson, parameters: params)
                .responseJSON { request, response, JSON, error in
                    var statusCode : Int = 0
                    if loging == true {
                        println("### SENDING ###")
                        println("➡️Request: \(method) on \(subpage) with \(params)")
                        if let resp = response {
                            statusCode = resp.statusCode
                            println("⬅️statusCode: \(statusCode)")
                            println("🔤Response: \(JSON)")
                        }
                        else {
                            statusCode = 0
                            println("⛔️\(error)")
                        }
                    }
                    if let json: AnyObject = JSON {
                        self.callback(callbackID, status: statusCode, data: json)
                    }
                    else {
                        self.callback(callbackID, status: statusCode, data: 0)
                    }
                    
            }
            
        default:
            println("default")
        }
    }
    
    func callback(id: Int, status: Int, data: AnyObject) {
        if id == 1 {
            self.loginCallback(status, data: data)
        }
    }
}













