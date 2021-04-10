//
//  MockSignupWebService.swift
//  PhotoUnitTesterTests
//
//  Created by George Cremer on 10/04/2021.
//

import Foundation
@testable import PhotoUnitTester

class MockSignupWebService: SignupWebServiceProtocol {
    
    var isSignupMethodCalled: Bool = false
    var shouldReturnError: Bool = false

    func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void) {
        
        isSignupMethodCalled = true
       
        if shouldReturnError {
            completionHandler(nil, SignupError.failedRequest(description: "Signup request was not successful"))
        } else {
            let responseModel = SignupResponseModel(status: "OK")
            completionHandler(responseModel,nil)
        }
      
    }
    
}
