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
            }
        }
        // FIXME: Is this a taboo name for a function?
        self.segueToTabBarController()
    }
    
    func segueToTabBarController() {
        dispatch_async(dispatch_get_main_queue(), {
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
            self.presentViewController(controller, animated: true, completion: nil)
        })
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