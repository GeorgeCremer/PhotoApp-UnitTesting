//
//  SignupWebServiceProtocol.swift
//  PhotoUnitTester
//
//  Created by George Cremer on 10/04/2021.
//

import Foundation

protocol SignupWebServiceProtocol {
    func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void)

}
