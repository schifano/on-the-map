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
        // MARK: API Keys
        static let ParseAppID: String = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let RestApiKey: String = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        
        // MARK: URLs
        static let BaseURLSecure: String = "https://udacity.com"
    }
    
    struct Methods {
        static let SessionAuthentication: String = "https://www.udacity.com/api/session"
        static let UserData: String = "https://www.udacity.com/api/users/"
        static let StudentLocation: String = "https://api.parse.com/1/classes/StudentLocation"
    }
    
    // MARK: JSON Body Keys {
    struct JSONBodyKeys {
        // MARK: POST - Creating a session
        static let Udacity = "udacity"
        static let Username = "username"
        static let Password = "password"
        
        // MARK: POST - Student Location
        static let UniqueKey = "uniqueKey"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let MapString = "mapString"
        static let MediaURL = "mediaURL"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
    }
    
    // MARK: JSON Response Keys
    struct JSONResponseKeys {
        // MARK: General
        static let StatusMessage = "status_message"
        static let StatusCode = "status_code"
        
        // MARK: Authorization
        static let RequestToken = "request_token"
        static let SessionID = "session_id"
        
        // MARK: Account
        static let UserID = "id"
    }
}