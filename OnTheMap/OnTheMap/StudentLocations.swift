//
//  StudentLocations.swift
//  OnTheMap
//
//  Created by Rachel Schifano on 2/18/16.
//  Copyright © 2016 schifano. All rights reserved.
//

import Foundation

struct StudentLocations {
    
    // MARK: Properties
    var firstName = ""
    var lastName = ""
    var latitude = 0.0
    var longitude = 0.0
    var mapString = ""
    var mediaURL = ""
    var objectID = ""
    var createdAt = ""
    var updatedAt = ""
    
    // MARK: Initializer
    init(dictionary: [String: AnyObject]) {
        firstName = dictionary[ParseClient.JSONResponseKeys.FirstName] as! String
        lastName = dictionary[ParseClient.JSONResponseKeys.LastName] as! String
        latitude = dictionary[ParseClient.JSONResponseKeys.Latitude] as! Double
        longitude = dictionary[ParseClient.JSONResponseKeys.Longitude] as! Double
        mapString = dictionary[ParseClient.JSONResponseKeys.MapString] as! String
        mediaURL = dictionary[ParseClient.JSONResponseKeys.MediaURL] as! String
        objectID = dictionary[ParseClient.JSONResponseKeys.ObjectID] as! String
        createdAt = dictionary[ParseClient.JSONResponseKeys.CreatedAt] as! String
        updatedAt = dictionary[ParseClient.JSONResponseKeys.UpdatedAt] as! String
    }
    
    // Helper: Given an array of dictionaries, conver them to an array of Student Location objects
    static func studentLocationsFromResults(results: [[String: AnyObject]]) -> [StudentLocations] {
        var studentLocations = [StudentLocations]()
        for result in results {
            studentLocations.append(StudentLocations(dictionary: result))
        }
        return studentLocations
    }
}