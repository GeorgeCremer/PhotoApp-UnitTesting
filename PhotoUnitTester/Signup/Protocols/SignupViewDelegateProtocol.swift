//
//  SignupViewDelegateProtocol.swift
//  PhotoUnitTester
//
//  Created by George Cremer on 10/04/2021.
//

import Foundation

protocol SignupViewDelegateProtocol: AnyObject {
    func successfulSignUp()
    func errorHandler(error: SignupError)
}
