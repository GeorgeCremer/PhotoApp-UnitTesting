//
//  SignupErrors.swift
//  PhotoUnitTester
//
//  Created by George Cremer on 09/04/2021.
//

import Foundation

enum SignupError: LocalizedError, Equatable {
    case invalidResponseModel
    case invalidRequestURLString
    case failedRequest(description: String)
    var errorDescription: String? {
        switch self {
        case let .failedRequest(description):
            return description
        case .invalidResponseModel, .invalidRequestURLString:
            return ""
        }
    }
}
