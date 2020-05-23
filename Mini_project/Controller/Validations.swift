//
//  Validations.swift
//  Mini_project
//
//  Created by KOTTE V S S DHEERAJ on 14/05/20.
//  Copyright © 2020 KOTTE V S S DHEERAJ. All rights reserved.
//

import Foundation

class Validation{
    
       func isValidPhone_no(value: String) -> Bool {
           let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
           let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
           let result = phoneTest.evaluate(with: value)
           return result
       }
       
       
       func isValidUsername(Input:String) -> Bool {
           let RegEx = "\\w{7,18}"
           let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: Input)
       }
       
       func isValidEmailAddress(emailAddressString: String) -> Bool {
           
           var returnValue = true
           let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
           
           do {
               let regex = try NSRegularExpression(pattern: emailRegEx)
               let nsString = emailAddressString as NSString
               let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
               
               if results.count == 0
               {
                   returnValue = false
               }
               
           } catch let error as NSError {
               print("invalid regex: \(error.localizedDescription)")
               returnValue = false
           }
           
           return  returnValue
       }
}
