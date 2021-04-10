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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        
        let urlSession = URLSession(configuration: config)
        sut = SignupWebService(urlString: SignupConstants.signupURLString, urlSession: urlSession)
        signFormRequestModel = SignupFormRequestModel(firstName: "Sergey", lastName: "Kargopolov", email: "test@test.com", password: "12345678")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        signFormRequestModel = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
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
    
    
    
    
    func testSignupWebService_WhenEmptyURLStringProvided_ReturnsError() {
        // Arrange
        let expectation = self.expectation(description: "An empty requestURL string expectation")
        sut = SignupWebService(urlString: "")
        
        // Act
        sut.signup(withForm: signFormRequestModel) { (signupResponseModel, error) in
            XCTAssertEqual(error, SignupError.invalidRequestURLString, "The signup() method did not return an expected error for the Failed Request")
            expectation.fulfill()
        }
        // Assert
        self.wait(for: [expectation], timeout: 2)
        
    }
    
    func testSignupWebService_WhenURLRequestFails_ReturnsErrorMessageDescription() {
        // Arrange
        let expectation = self.expectation(description: "A failed Request expectation")
        let errorDescription = "The operation couldn’t be completed. (PhotoUnitTester.SignupError error 0.)"
        MockURLProtocol.error = SignupError.failedRequest(description: errorDescription)

        // Act
        sut.signup(withForm: signFormRequestModel) { _, error in
            // Assert
            XCTAssertEqual(error, SignupError.failedRequest(description: errorDescription), "The signup() method did not return an expecter error for the Failed Request")
            // XCTAssertEqual(error?.localizedDescription, errorDescription)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }
    
    
}
