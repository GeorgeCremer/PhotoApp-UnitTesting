//
//  SignupPresenterProtocol.swift
//  PhotoUnitTester
//
//  Created by George Cremer on 10/04/2021.
//

import Foundation

protocol SignupPresenterProtocol: AnyObject {
    
    init(formModelValidator: SignupModelValidatorProtocol, webService: SignupWebServiceProtocol,  delegate: SignupViewDelegateProtocol) 
    func processUserSignup(formModel: SignupFormModel)

}
