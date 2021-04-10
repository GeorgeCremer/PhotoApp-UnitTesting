//
//  MockSignupViewDelegate.swift
//  PhotoUnitTesterTests
//
//  Created by George Cremer on 10/04/2021.
//

import Foundation
import XCTest
@testable import PhotoUnitTester
class MockSignupViewDelegate: SignupViewDelegateProtocol {
   
    var expectation: XCTestExpectation?
    var successfulSignUpCounter = 0
    var errorHandlerCounter = 0
    var signupError: SignupError?
    
    func successfulSignUp() {
        successfulSignUpCounter += 1
        expectation?.fulfill()
    }
    
    func errorHandler(error: SignupError) {
        signupError = error
        errorHandlerCounter += 1
        expectation?.fulfill()
    }
    
}
