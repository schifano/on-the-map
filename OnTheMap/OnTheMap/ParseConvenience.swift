//
//  ParseConvenience.swift
//  OnTheMap
//
//  Created by Rachel Schifano on 2/16/16.
//  Copyright © 2016 schifano. All rights reserved.
//

import Foundation

extension ParseClient {
    
    // MARK: GET Convenience Method
    func getMapStudentLocations(completionHandler: (result: [StudentLocations]?, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST)*/
        let parameters = [ParseClient.JSONBodyKeys.Limit: ParseClient.Constants.Number]
        
        /* 2. Make the request */
        let task = taskForGETMethod(ParseClient.Methods.StudentLocation, parameters: parameters) { JSONResult, error in
            
            /* 3. Send the desired value(s) to the completion handler */
            if let error = error {
                completionHandler(result: nil, error: error)
            } else {
                if let results = JSONResult[ParseClient.JSONResponseKeys.Results] as? [[String: AnyObject]] {
                    let locations = StudentLocations.studentLocationsFromResults(results)
                    completionHandler(result: locations, error: nil)
                } else {
                    completionHandler(result: nil, error: NSError(domain: "getMapStudentLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse locations from getMapStudentLocations"]))
                }
            }
        }
        return task
    }
    
    // MARK: POST Convenience Method
    // Needed for submitting a location
    func postStudentLocations() {
    }
}