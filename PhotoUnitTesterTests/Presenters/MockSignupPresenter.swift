//
//  MockSignupPresenter.swift
//  PhotoUnitTesterTests
//
//  Created by George Cremer on 10/04/2021.
//

import Foundation
@testable import PhotoUnitTester

class MockSignupPresenter: SignupPresenterProtocol {
 
    var processUserSignupCalled: Bool = false

    required init(formModelValidator: SignupModelValidatorProtocol, webService: SignupWebServiceProtocol, delegate: SignupViewDelegateProtocol) {
        // TODO
    }
    
    func processUserSignup(formModel: SignupFormModel) {
        processUserSignupCalled = true
    }
    
    
    
    
}
