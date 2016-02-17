//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Rachel Schifano on 2/16/16.
//  Copyright © 2016 schifano. All rights reserved.
//

import Foundation

class ParseClient: NSObject {
    
    // MARK: Properties
    var session: NSURLSession
    
    override init() {
        session = NSURLSession.sharedSession()
        super.init()
    }
    
    // MARK: POST
    func taskForPOSTMethod(method: String, parameters: [String: AnyObject]?, jsonBody: [String: AnyObject], completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        /* 1. Set the parameters ... if there were any */
        /* 2/3. Build the URL and configure the request */
        let urlString = ParseClient.Constants.BaseURLSecure + method
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.addValue(Constants.ParseApplicationID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(Constants.ParseAPIKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(jsonBody, options: .PrettyPrinted)
        }
        print("request: \(request)")
        
        /* 4. Make the request */
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                print("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                if let response = response as? NSHTTPURLResponse {
                    print("Your request returned an invalid response! Status code: \(response.statusCode)!")
                } else if let response = response {
                    print("Your request returned an invalid response! Response: \(response)!")
                } else {
                    print("Your request returned an invalid response!")
                }
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                print("No data was returned by the request!")
                return
            }
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            ParseClient.parseJSONWithCompletionHandler(data, completionHandler: completionHandler)
        }
        /* 7. Start the request */
        task.resume()
        return task
    }

    // MARK: GET
    func taskForGETMethod(method: String, parameters: [String: AnyObject]?, completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        /* 1. Set the parameters...there are no parameters */
        
        /* 2/3. Build the URL and configure the request */
        let urlString = ParseClient.Constants.BaseURLSecure + method
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
        request.addValue(ParseClient.Constants.ParseApplicationID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseClient.Constants.ParseAPIKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        /* 4. Make the request */
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            /* GUARD: Was there an error? */
            guard error == nil else {
                print("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                if let response = response as? NSHTTPURLResponse {
                    print("Your request returned an invalid response! Status code: \(response.statusCode)")
                } else if let response = response {
                    print("Your request returned an invalid response! Response: \(response)")
                } else {
                    print("Your request returned an invalid response.")
                }
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                print("There was no data returned by the request.")
                return
            }
            
            /* 5/6. Parse the data */
            UdacityClient.parseJSONWithCompletionHandler(data, completionHandler: completionHandler)
        }
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    
    // FIXME: Redundant use of helper methods, need to call class to specify which methods to access sinc similar across ParseClient and UdacityClient
    
    // Helper Methods
    class func substituteKeyInMethod(method: String, key: String, value: String) -> String? {
        if method.rangeOfString("{\(key)}") != nil {
            return method.stringByReplacingOccurrencesOfString("{\(key)}", withString: value)
        } else {
            return nil
        }
    }
    
    class func parseJSONWithCompletionHandler(data: NSData, completionHandler: (result: AnyObject!, error: NSError?) -> Void ) {
        var parsedResult: AnyObject!
        do {
            parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey: "Could not parse the data as JSON: '\(data)"]
            completionHandler(result: nil, error: NSError(domain: "parseJSONWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        completionHandler(result: parsedResult, error: nil)
    }
    
    class func escapedParameters(parameters: [String: AnyObject]) -> String {
        var urlVars = [String]()
        for (key, value) in parameters {
            // Make sure it is a string value
            let stringValue = "\(value)"
            
            // Escape it
            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            
            // Append it
            urlVars += [key + "=" + "\(escapedValue!)"]
        }
            return (!urlVars.isEmpty ? "?" : "") + urlVars.joinWithSeparator("&")
    }
    
    // MARK: Shared Instance
    class func sharedInstance() -> ParseClient {
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        return Singleton.sharedInstance
    }
}