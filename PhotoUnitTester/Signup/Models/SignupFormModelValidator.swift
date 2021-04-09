//
//  SignupFormModelValidator.swift
//  PhotoUnitTester
//
//  Created by George Cremer on 09/04/2021.
//

import Foundation



class SignupFormModelValidator {
 
    func isFirstNameValid(firstName: String) -> Bool {
        var returnValue = true
        
        if firstName.count < SignupConstants.firstNameMinimumLength || firstName.count > SignupConstants.firstNameMaximumLength {
            returnValue = false
        }
        return returnValue
    }
    
    func doPasswordsMatch(password: String ,repeatPassword: String) -> Bool {
        return password == repeatPassword
    }

}
