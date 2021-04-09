//
//  SignUpWebServiceTests.swift
//  PhotoUnitTesterTests
//
//  Created by George Cremer on 09/04/2021.
//

@testable import PhotoUnitTester
import XCTest
class SignUpWebServiceTests: XCTestCase {
    var sut: SignupWebService!
    var signFormRequestModel: SignupFormRequestModel!

    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        sut = SignupWebService(urlString: SignupConstants.signupURLString, urlSession: urlSession)
        signFormRequestModel = SignupFormRequestModel(firstName: "Tester", lastName: "Tester", email: "Tester@test.com", password: "12345")
    }

    override func tearDownWithError() throws {
        sut = nil
        signFormRequestModel = nil
    }

    func testSignupWebService_WhenGivenSuccessfulResponse_ReturnsSuccess() {
        // Arrange
        let jsonString = "{\"status\":\"ok\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        let expectation = self.expectation(description: "Signup Web Service Response Expectation")

        // Act
        sut.signup(withForm: signFormRequestModel) { signupResponseModel, _ in

            // Assert
            XCTAssertEqual(signupResponseModel?.status, "ok")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }

    func testSignupWebService_WhenGivenUnsuccessfulResponse_ErrorTookPlace() {
        // Arrange
        let jsonString = "{\"path\":\"/users\", \"error\":\"Internal Server Error\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        let expectation = self.expectation(description: "Signup() method expectation for a response that contains a different JSON structure.")

        // Act
        sut.signup(withForm: signFormRequestModel) { signupResponseModel, error in

            // Assert
            XCTAssertNil(signupResponseModel, "The response model for a request containing unknown JSON response that contains a different JSON structure. Should have been NIL")
            XCTAssertEqual(error, SignupError.invalidResponseModel, "The signup method did not return the expected error.")

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }
}
