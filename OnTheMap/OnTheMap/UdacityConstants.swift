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
}