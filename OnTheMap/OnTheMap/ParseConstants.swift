//
//  ParseConstants.swift
//  OnTheMap
//
//  Created by Rachel Schifano on 2/16/16.
//  Copyright © 2016 schifano. All rights reserved.
//

import UIKit
import Foundation

extension ParseClient {
    
    // MARK: Constants
    struct Constants {
        // MARK: API keys
        static let ParseAPIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let ParseApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        
        // MARK: URLs
        static let BaseURLSecure = "https://api.parse.com/1/classes/"
    }
    
    struct Methods {
        static let StudentLocation: String = "StudentLocation"
    }
    
    // MARK: JSON Body Keys
    struct JSONBodyKeys {
        static let UniqueKey = "uniqueKey"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let MapString = "mapString"
        static let MediaURL = "mediaURL"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let Limit = "limit"
    }
    
    // MARK: JSON Response Keys
    struct JSONResponseKeys {
        static let ObjectID = "objectID"
        static let UniqueKey = "uniqueKey"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let MapString = "mapString"
        static let MediaURL = "mediaURL"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let CreatedAt = "createdAt"
        static let UpdatedAt = "updatedAt"
        static let ACL = "ACL"
    }
}