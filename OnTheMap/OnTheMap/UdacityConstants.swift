//
//  UdacityConstants.swift
//  OnTheMap
//
//  Created by Rachel Schifano on 1/9/16.
//  Copyright © 2016 schifano. All rights reserved.
//

import UIKit
import Foundation

extension UdacityClient {
    struct Constants {
        // MARK: URLs
        static let BaseURLSecure: String = "https://www.udacity.com/api/"
    }
    
    struct Methods {
        static let Session: String = "session"
        static let Users: String =  "users/{user_id}"
    }
    
    struct URLKeys {
        static let UserID: String = "user_id"
    }
    
    // MARK: JSON Body Keys {
    struct JSONBodyKeys {
        // MARK: POST - Creating a session
        static let Udacity = "udacity"
        static let Username = "username"
        static let Password = "password"
    }
    
    // MARK: JSON Response Keys
    struct JSONResponseKeys {
        // MARK: Login
        static let UserKey = "key"
        static let Account = "account"
        static let Session = "session"
        static let ID = "id"
        static let User = "user"
        static let FirstName = "first_name"
        static let LastName = "last_name"
    }
    
    struct StudentInformation {
        static var userID = ""
        static var firstName = ""
        static var lastName = ""
    }
}