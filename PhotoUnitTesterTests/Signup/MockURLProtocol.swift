//
//  MockURLProtocol.swift
//  PhotoUnitTesterTests
//
//  Created by George Cremer on 09/04/2021.
//

import Foundation

class MockURLProtocol: URLProtocol {
    static var stubResponseData: Data?
    static var error: Error?

    override class func canInit(with _: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let signupError = MockURLProtocol.error {
            client?.urlProtocol(self, didFailWithError: signupError)
        } else {
            client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data())
        }

        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
