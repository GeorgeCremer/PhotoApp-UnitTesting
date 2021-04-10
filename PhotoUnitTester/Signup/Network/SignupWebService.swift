//
//  SignupWebService.swift
//  PhotoUnitTester
//
//  Created by George Cremer on 09/04/2021.
//

import Foundation

class SignupWebService: SignupWebServiceProtocol {
    private var urlString: String
    private var urlSession: URLSession

    init(urlString: String, urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }

    func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(nil, SignupError.invalidRequestURLString)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(formModel)

        let dataTask = urlSession.dataTask(with: request) { data, _, error in

            if let requestError = error {
                completionHandler(nil, SignupError.failedRequest(description: requestError.localizedDescription))
                return
            }

            if let data = data, let signupResponseModel = try? JSONDecoder().decode(SignupResponseModel.self, from: data) {
                completionHandler(signupResponseModel, nil)
            } else {
                completionHandler(nil, SignupError.invalidResponseModel)
            }
        }

        dataTask.resume()
    }
}
