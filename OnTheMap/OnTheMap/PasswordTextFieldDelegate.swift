//
//  PasswordTextFieldDelegate.swift
//  OnTheMap
//
//  Created by Rachel Schifano on 1/4/16.
//  Copyright © 2016 schifano. All rights reserved.
//

import Foundation
import UIKit

class PasswordTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let currentString: NSString = textField.text!
        let newString: NSString = currentString.stringByReplacingCharactersInRange(range, withString: string)
        textField.text = newString as String
        return true
    }
}