//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Rachel Schifano on 1/9/16.
//  Copyright © 2016 schifano. All rights reserved.
//

import Foundation

// Makes POST / GET calls
class UdacityClient: NSObject {
    
    // MARK: Properties
    // Shared session
    var session: NSURLSession
    
    // MARK: Initializers
    override init() {
        session = NSURLSession.sharedSession()
        super.init()
    }
    
    // GET
    
    
    // POST
    
    
    
    class func escapedParameters(parameters: [String : AnyObject]) -> String {
        var urlVars = [String]()
        
        for (key, value) in parameters {
            /* Make sure that it is a string value */
            let stringValue = "\(value)"
            /* Escape it */
            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            /* Append it */
            urlVars += [key + "=" + "\(escapedValue!)"]
        }
        return (!urlVars.isEmpty ? "?" : "") + urlVars.joinWithSeparator("&")
    }
    
    // MARK: Shared Instance
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
}