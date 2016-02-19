//
//  StudentLocations.swift
//  OnTheMap
//
//  Created by Rachel Schifano on 2/18/16.
//  Copyright © 2016 schifano. All rights reserved.
//

import Foundation

struct StudentLocations {
    
    // bug is not here TEST
    // MARK: Properties
    var firstName: String? = nil
    var lastName: String? = nil
    var latitude: Float = 0.0
    var longitude: Float = 0.0
    var mapString: String? = nil
    var mediaURL: String? = nil
    var objectID: String? = nil
//    var createdAt = ""
//    var updatedAt = ""
    var uniqueKey: String? = nil
    
    // MARK: Initializer
    init(dictionary: [String: AnyObject]) {
        firstName = dictionary[ParseClient.JSONResponseKeys.FirstName] as? String
        lastName = dictionary[ParseClient.JSONResponseKeys.LastName] as? String
        latitude = dictionary[ParseClient.JSONResponseKeys.Latitude] as! Float
        longitude = dictionary[ParseClient.JSONResponseKeys.Longitude] as! Float
        mapString = dictionary[ParseClient.JSONResponseKeys.MapString] as? String
        mediaURL = dictionary[ParseClient.JSONResponseKeys.MediaURL] as? String
        objectID = dictionary[ParseClient.JSONResponseKeys.ObjectID] as? String
//        createdAt = dictionary[ParseClient.JSONResponseKeys.CreatedAt] as! String
//        updatedAt = dictionary[ParseClient.JSONResponseKeys.UpdatedAt] as! String
        uniqueKey = dictionary[ParseClient.JSONResponseKeys.UniqueKey] as? String
    }
    
    // Helper: Given an array of dictionaries, conver them to an array of Student Location objects
    static func studentLocationsFromResults(results: [[String: AnyObject]]) -> [StudentLocations] {
        var studentLocations = [StudentLocations]()
        var counter: Int = 0
//        print("results before for loop: \(results)") // TEST
        for result in results {
            studentLocations.append(StudentLocations(dictionary: result))
            print(counter++) // TEST
        } // breaks, unwrap optional and nil
        print("completed adding StudentLocations objects to studentLocations: \(studentLocations)") // TEST
        return studentLocations
    }
}