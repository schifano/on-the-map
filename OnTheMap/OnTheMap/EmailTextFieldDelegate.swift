//
//  EmailTextFieldDelegate.swift
//  OnTheMap
//
//  Created by Rachel Schifano on 1/4/16.
//  Copyright © 2016 schifano. All rights reserved.
//

import UIKit
import Foundation

class EmailTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        
        return true
    }
}