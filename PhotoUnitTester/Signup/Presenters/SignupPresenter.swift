//
//  SignupPresenter.swift
//  PhotoUnitTester
//
//  Created by George Cremer on 09/04/2021.
//

import Foundation

class SignupPresenter{
 
    private var formModelValidator: SignupModelValidatorProtocol
    private var webService: SignupWebServiceProtocol!
    private weak var delegate: SignupViewDelegateProtocol?
    
    init(formModelValidator: SignupModelValidatorProtocol, webService: SignupWebServiceProtocol,  delegate: SignupViewDelegateProtocol) {
        self.formModelValidator = formModelValidator
        self.webService = webService
        self.delegate = delegate
    }
    
    func processUserSignup(formModel: SignupForModel) {
        
        if !formModelValidator.isFirstNameValid(firstName: "") {
            return
        }
        
        if !formModelValidator.isLastNameValid(lastName: "") {
            return
        }
        
        if !formModelValidator.isPasswordValid(password: "") {
            return
        }
        
        if !formModelValidator.isValidEmailFormat(email: "") {
            return
        }
        
        if !formModelValidator.doPasswordsMatch(password: "", repeatPassword: "") {
            return
        }
        
        
        let requestModel = SignupFormRequestModel(firstName: formModel.firstName, lastName: formModel.lastName, email: formModel.email, password: formModel.password)
        
        webService.signup(withForm: requestModel) { [weak self] (responseModel, error) in
            
            if let error = error {
                self?.delegate?.errorHandler(error: error)
                return
            }
            
            if let _ = responseModel {
                self?.delegate?.successfulSignUp()
                return
            }
        }
        
        
        
        
    }
}
