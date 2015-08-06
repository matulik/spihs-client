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
    
    init() {
        //        TODO INITIALIZATION
    }
    
    
    // ID = 1
    func login() {
        let parameters = [
            "username": self.username,
            "password": self.password
        ]
        self.sendRequest("POST", subpage: "login/", returnType: "JSON", params: parameters, callbackID: 1, loging: true)
    }
    
    func loginCallback(data: AnyObject) {
        
    }
    
    // ID = 2
    func logout() {
        self.sendRequest("GET", subpage: "logout/", returnType: "DEFAULT", params: ["":""], callbackID: 2, loging: false)
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
                    if loging == true {
                        println("######Request: \(method) on \(subpage)######\n\(request)\n######EndOfRequest")
                        println("######Response:\n\(response)\n######EndOfResponse")
                        println("######Data:\n\(data)\n######EndOfData")
                        println("######Error:\n\(error)\n######EndOfError######")
                    }
                    self.callback(callbackID, data: data!)
            }
            
        case "JSON":
            Alamofire.request(httpMethod!, host+subpage+fjson, parameters: params)
                .responseJSON { request, response, JSON, error in
                    if loging == true {
                        println("######Request: \(method) on \(subpage)######\n\(request)\n######EndOfRequest")
                        println("######Response:\n\(response)\n######EndOfResponse\n")
                        println("######JSON:\n\(JSON)\n######EndOfJSON\n")
                        println("######Error:\n\(error)\n######EndOfError\n")
                    }
                    self.callback(callbackID, data: JSON!)
            }
            
        default:
            println("default")
        }
    }
    
    func callback(id: Int, data: AnyObject) {
        if id == 1 {
            self.loginCallback(data)
        }
    }
}













