//
//  Request.swift
//  spihs-client
//
//  Created by matulik on 06/08/15.
//  Copyright (c) 2015 mt. All rights reserved.
//

import Foundation
import Alamofire

let fjson = "?format=json"

class Request {
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
    
    func sendNotification(observerName: String, userInfo: [String:String]) {
        NSNotificationCenter.defaultCenter().postNotificationName(observerName, object: nil, userInfo: userInfo)
    }
    
    func callback(id: Int, status: Int, data: AnyObject) {
        fatalError("Method must be override!")
    }
}