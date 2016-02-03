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
    
    var appDelegate: AppDelegate!
    var session: NSURLSession!
    
    var backgroundGradient: CAGradientLayer? = nil
    var tapRecognizer: UITapGestureRecognizer? = nil
    
    var keyboardAdjusted = false
    var lastKeyboardOffset: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Get the app delegate */
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        /* Get the shared URL session */
        session = NSURLSession.sharedSession()
        
        /* Configure the UI */
        self.configureUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
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
        getSessionID()
    }
    
    func getSessionID() {
        
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