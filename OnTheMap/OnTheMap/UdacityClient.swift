//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Rachel Schifano on 1/9/16.
//  Copyright © 2016 schifano. All rights reserved.
//

import Foundation

class UdacityClient: NSObject {
    
    // MARK: Properties
    // Shared session
    var session: NSURLSession
    
    // Authentication
    var sessionID: String? = nil
    var userID: Int? = nil
    
    // MARK: Initializers
    override init() {
        session = NSURLSession.sharedSession()
        super.init()
    }
    
    
    // MARK: Shared Instance
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
}