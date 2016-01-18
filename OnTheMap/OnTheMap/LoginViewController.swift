//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Rachel Schifano on 12/31/15.
//  Copyright © 2015 schifano. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var appDelegate: AppDelegate!
    var session: NSURLSession!
    
    // TODO: Add constraints and aesthetics to text fields
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Get the app delegate */
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        /* Get the shared URL session */
        session = NSURLSession.sharedSession()
    }
}