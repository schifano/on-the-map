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
    
    func authenticateWithUdacity(username: String, password: String, completionHandler: (success: Bool, errorString: NSError?) -> Void) {
     
        print("reached authenticateWithUdacity method")
        // login to udacity using username and password instead of token
        loginWithUdacity(username, password: password) { (success, userID, error) in
            
            if success {
                if let userID = userID {
                    // Store the returned userID
                    UdacityClient.StudentInformation.userID = userID
                    
                    self.getPublicUserData() { (success, firstName, lastName, error) in
                        if success {
                            UdacityClient.StudentInformation.firstName = firstName!
                            UdacityClient.StudentInformation.lastName = lastName!
                        } else {
                            completionHandler(success: success, errorString: error)
                        }
                    }
                    completionHandler(success: success, errorString: error)
                }
            } else {
                completionHandler(success: success, errorString: error)
            }
        }
    }
    
    // MARK: POST Convenience Method
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
                if let results = JSONResult[UdacityClient.JSONResponseKeys.Account] as? [String: AnyObject] {
                    let userID = results[UdacityClient.JSONResponseKeys.UserKey] as? String
                    print("userID after results: \(userID)") // TEST
                    completionHandler(success: true, userID: userID, errorString: nil)
                } else {
                    completionHandler(success: true, userID: nil, errorString: NSError(domain: "Login parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse loginWithUdacity"]))
                }
            }
        }
    }
    
    // MARK: GET Convenience Method
    func getPublicUserData(completionHandler: (success: Bool, firstName: String?, lastName: String?, error: NSError?) -> Void) {
        /* 1. Specify the parameters, method (if has {key}), and HTTP body (if POST) */
        var mutableUserMethod: String = UdacityClient.Methods.Users
        mutableUserMethod = UdacityClient.substituteKeyInMethod(mutableUserMethod, key: UdacityClient.URLKeys.UserID, value: String(UdacityClient.StudentInformation.userID))!
        
        /* 2. Make the request */
        taskForGETMethod(mutableUserMethod, parameters: nil) { JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(success: false, firstName: nil, lastName: nil, error: error)
            } else {
                if let results = JSONResult[UdacityClient.JSONResponseKeys.User] as? [String: AnyObject]{
                    let firstName = results[UdacityClient.JSONResponseKeys.FirstName] as? String
                    let lastName = results[UdacityClient.JSONResponseKeys.LastName] as? String
                    completionHandler(success: true, firstName: firstName, lastName: lastName, error: nil)
                } else {
                    completionHandler(success: false, firstName: nil, lastName: nil, error: NSError(domain: "getPublicUserData", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse results"]))
                }
            }
        }
    }
    
    
    
    
}