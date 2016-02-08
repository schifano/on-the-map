//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Rachel Schifano on 12/31/15.
//  Copyright © 2015 schifano. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var debugTextLabel: UILabel!
    
    var appDelegate: AppDelegate!
    
    var backgroundGradient: CAGradientLayer? = nil
    var tapRecognizer: UITapGestureRecognizer? = nil
    var keyboardAdjusted = false
    var lastKeyboardOffset: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        /* Configure the UI */
        self.configureUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        debugTextLabel.hidden = true
        subscribeToKeyboardNotifications()
        addKeyboardDismissRecognizer()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(true)
        unsubscribeToKeyboardNotifications()
        removeKeyboardDismissRecognizer()
    }
    
    // MARK: Signup Methods
    @IBAction func signUpButtonTouch(sender: UIButton) {
        let request = NSURLRequest(URL: NSURL(string: "https://www.udacity.com/account/auth#!/signup")!)
        UIApplication.sharedApplication().openURL(request.URL!)
    }
    
    // MARK: Login Methods
    @IBAction func loginButtonTouch(sender: UIButton) {
        // TODO: Call alert view controller for credential errors
        // TODO: Call alert view controller for login connection errors

        // Unwrap optional text field text to pass as a parameter
        guard let email = emailTextField.text else {
            print("Email text field is nil")
            return
        }
        
        guard let pw = passwordTextField.text else {
            print("Password text field is nil")
            return
        }
        
        // guard statements check for the expected behavior
        guard email.characters.count > 0 && pw.characters.count > 0 else {
            print("Email text field is empty")
            let alertController = UIAlertController(title: nil, message: "Email or password field is empty.", preferredStyle: .ActionSheet)
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            }
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true) {
            }
            return
        }
        
        print("Email \(email) and Password \(pw)")
        
        // Authenticate with given user data
        UdacityClient.sharedInstance().authenticateWithUdacity(email, password: pw) { (success, errorString) in
            
            if (success) {
                // present view controller
                print("present view controller")
            } else {
                // present error
                // NSAlertError?
            }
        }
        // FIXME: Is this a taboo name for a function?
        self.segueToTabBarController()

        //        getSessionID()
    }
    
    func segueToTabBarController() {
        dispatch_async(dispatch_get_main_queue(), {
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
            self.presentViewController(controller, animated: true, completion: nil)
        })
    }
    
    func getSessionID() {
        /* 1 & 2 Set the parameters ... no previous setup required for Udacity API */
//        let methodParameters = [
//            "username": emailTextField.text,
//            "password": passwordTextField.text
//        ]

        // Unwrap the optional text field text
        guard let email = emailTextField.text else {
            print("Email text field is empty")
            return
        }
        guard let pw = passwordTextField.text else {
            print("Password text field is empty")
            return
        }
        
        print("Email text field: \(email)")
        print("PW text field: \(pw)")
        
        /* 3. Configure the request */
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"udacity\": {\"username\": \"\(email)\", \"password\":\(pw)\"\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        let session = NSURLSession.sharedSession()
        /* 4. Make the request */
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                dispatch_async(dispatch_get_main_queue()) {
                    self.debugTextLabel.text = "Session failed"
                }
                print("There was an error with starting the session: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                if let response = response as? NSHTTPURLResponse {
                    print( "Your request returned an invalid response! Status code: \(response.statusCode)!")
                } else if let response = response {
                    print("Your request returned an invalid response! Response: \(response)!")
                } else {
                    print("Your request returned an invalid response!")
                }
                return
            }
            
            /* 5. Parse the data */
            let newData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5)) /* subset response data! */
            print(NSString(data: newData, encoding: NSUTF8StringEncoding))

            let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments)
            } catch {
                parsedResult = nil
                print("Could not parse the data as JSON: '\(newData)'")
                return
            }

            guard (parsedResult.objectForKey("status_code") == nil) else {
                print("See the status_code and status_message in \(parsedResult)")
                return
            }
        }
        task.resume()
    }
    
    // FIXME: Do I even need this
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: LoginViewController (ConfigureUI)
extension LoginViewController {
    // TODO: Add constraints and aesthetics to text fields
    func configureUI() {
        /* Configure Background Gradient */
        // set background color to clear so that the gradient can be drawn on top of it
        self.view.backgroundColor = UIColor.clearColor()
        let colorTop = UIColor(red: 1.0, green: 0.596, blue: 0.043, alpha: 1.0).CGColor
        let colorBottom = UIColor(red: 1.0 , green: 0.439, blue: 0.0, alpha: 1.0).CGColor
        backgroundGradient = CAGradientLayer()
        backgroundGradient!.colors = [colorTop, colorBottom]
        backgroundGradient!.locations = [0.0, 1.0]
        backgroundGradient!.frame = view.frame
        self.view.layer.insertSublayer(backgroundGradient!, atIndex: 0)
        
        // button color
        loginButton.backgroundColor = UIColor(red: 0.953, green: 0.341, blue: 0.0073, alpha: 1.0)
        
        /* Configure Tap Recognizer */
        tapRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        tapRecognizer?.numberOfTapsRequired = 1
    }
}

// MARK: LoginViewController - Show/Hide Keyboard, UITapGestureRecognizer
extension LoginViewController {
    // TODO: Dismiss keyboard
    func addKeyboardDismissRecognizer() {
        self.view.addGestureRecognizer(tapRecognizer!)
    }
    
    func removeKeyboardDismissRecognizer() {
        self.view.removeGestureRecognizer(tapRecognizer!)
    }
    
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if keyboardAdjusted == false {
            lastKeyboardOffset = getKeyboardHeight(notification) / 2
            self.view.superview?.frame.origin.y -= lastKeyboardOffset
            keyboardAdjusted = true
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if keyboardAdjusted == true {
            self.view.superview?.frame.origin.y += lastKeyboardOffset
            keyboardAdjusted = false
        }
    }

    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
}

extension LoginViewController {
    
    /* Helper function: Given a dictionary of parameters, convert to a string for a url */
    func escapedParameters(parameters: [String : AnyObject]) -> String {
        
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
}