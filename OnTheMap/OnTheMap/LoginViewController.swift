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
    
    var appDelegate: AppDelegate!
    var session: NSURLSession!
    
    var backgroundGradient: CAGradientLayer? = nil
    
    // TODO: Add constraints and aesthetics to text fields
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Get the app delegate */
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        /* Get the shared URL session */
        session = NSURLSession.sharedSession()
        
        /* Configure the UI */
        self.configureUI()
    }
}

// TODO: Dismiss keyboard

// MARK: LoginViewController (ConfigureUI)
extension LoginViewController {
    func configureUI() {
        /* Configure Background Gradient */
        // set background color to clear so that the gradient can be drawn on top of it
        self.view.backgroundColor = UIColor.clearColor()
        let colorTop = UIColor(red: 1.0, green: 0.67, blue: 0.2, alpha: 1.0).CGColor
        let colorBottom = UIColor(red: 0.886, green: 0.37, blue: 0.05, alpha: 1.0).CGColor
        backgroundGradient = CAGradientLayer()
        backgroundGradient!.colors = [colorTop, colorBottom]
        backgroundGradient!.locations = [0.0, 1.0]
        backgroundGradient!.frame = view.frame
        self.view.layer.insertSublayer(backgroundGradient!, atIndex: 0)
    }
}