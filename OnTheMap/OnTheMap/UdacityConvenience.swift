//
//  UdacityConvenience.swift
//  OnTheMap
//
//  Created by Rachel Schifano on 1/26/16.
//  Copyright © 2016 schifano. All rights reserved.
//

import Foundation
import UIKit

// Makes authentication / login calls

extension UdacityClient {
    
    func authenticateWithUdacity(username: String, password: String, completionHandler: (success: Bool, userID: String?, errorString: NSError?) -> Void) {
     
        print("reached authenticateWithUdacity method")
        // login to udacity using username and password instead of token
        loginWithUdacity(username, password: password) { (success, userID, error) in
            if success {
                // unwrap optional value returned
                if let userID = userID {
                    // Store the returned userID
                    UdacityClient.StudentInformation.userID = userID
                }
            }
        }
    }
    
    func loginWithUdacity(username: String, password: String, completionHandler: (success: Bool, userID: String?, errorString: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let userInfo: [String: String] = [UdacityClient.JSONBodyKeys.Username: username, UdacityClient.JSONBodyKeys.Password: password]
        let jsonBody: [String: AnyObject] = [UdacityClient.JSONBodyKeys.Udacity: userInfo]
        
        /* 2. Make the request */
        taskForPOSTMethod(UdacityClient.Methods.Session, parameters: nil, jsonBody: jsonBody) { JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(success: false, userID: nil, errorString: error)
            } else {
                if let results = JSONResult[UdacityClient.JSONResponseKeys.UserKey] as? [String: AnyObject] {
                    let userID = results[UdacityClient.JSONResponseKeys.UserKey] as? String
                    completionHandler(success: true, userID: userID, errorString: nil)
                } else {
                    completionHandler(success: true, userID: nil, errorString: NSError(domain: "Login parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse loginWithUdacity"]))
                }
            }
        }
    }
    
//    func getPublicUserData(completionHandler: (success: Bool, firstName: String?, lastName: String?, error: NSError?) -> Void {
//        
//    }
    
}