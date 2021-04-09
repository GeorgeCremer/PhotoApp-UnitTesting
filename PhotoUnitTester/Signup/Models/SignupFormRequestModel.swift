//
//  SignupFormRequestModel.swift
//  PhotoUnitTester
//
//  Created by George Cremer on 09/04/2021.
//

import Foundation

struct SignupFormRequestModel: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}
