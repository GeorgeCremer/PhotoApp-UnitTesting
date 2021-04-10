//
//  MockSignupValidator.swift
//  PhotoUnitTesterTests
//
//  Created by George Cremer on 09/04/2021.
//

import Foundation
@testable import PhotoUnitTester

class MockSignupValidator: SignupModelValidatorProtocol {
   
    var isFirstNameValidated: Bool = false
    var isLastNameValidated: Bool = false
    var isEmailValidated:Bool = false
    var isPasswordValidated:Bool = false
    var isPasswordEqualityValidated:Bool = false



    func isFirstNameValid(firstName: String) -> Bool {
        isFirstNameValidated = true
        return isFirstNameValidated
    }
    
    func isLastNameValid(lastName: String) -> Bool {
        isLastNameValidated = true
        return isLastNameValidated
    }
    
    func isValidEmailFormat(email: String) -> Bool {
        isEmailValidated = true
        return isEmailValidated
    }
    
    func isPasswordValid(password: String) -> Bool {
        isPasswordValidated = true
        return isPasswordValidated
    }
    
    func doPasswordsMatch(password: String, repeatPassword: String) -> Bool {
        isPasswordEqualityValidated = true
        return isPasswordEqualityValidated
    }
    
    
}
