//
//  SignupPresenterTests.swift
//  PhotoUnitTesterTests
//
//  Created by George Cremer on 09/04/2021.
//

import XCTest
@testable import PhotoUnitTester

class SignupPresenterTests: XCTestCase {
    var signupFormModel: SignupForModel!
    var mockSignupModelValidator: MockSignupValidator!
    var mockSignupWebService: MockSignupWebService!
    var sut: SignupPresenter!
    var mockSignupViewDelegate: MockSignupViewDelegate!

    
    override func setUpWithError() throws {
         signupFormModel = SignupForModel(firstName: "Test", lastName: "Tester", email: "Tester@test.com", password: "12345", repeatPassword: "12345")
         mockSignupModelValidator = MockSignupValidator()
         mockSignupWebService = MockSignupWebService()
         mockSignupViewDelegate = MockSignupViewDelegate()
         sut = SignupPresenter(formModelValidator: mockSignupModelValidator, webService: mockSignupWebService, delegate: mockSignupViewDelegate)
        }

    override func tearDownWithError() throws {
        signupFormModel = nil
        mockSignupModelValidator = nil
        mockSignupWebService = nil
        mockSignupViewDelegate = nil
        sut = nil

    }


    func testSignupPresenter_WhenInformationProvided_WillValidateEachProperty() {
        
        // Arrange

        // Act
        sut.processUserSignup(formModel: signupFormModel)

        // Assert
        XCTAssertTrue(mockSignupModelValidator.isFirstNameValidated, "First name was not validated")
        XCTAssertTrue(mockSignupModelValidator.isLastNameValidated, "Last name was not validated")
        XCTAssertTrue(mockSignupModelValidator.isEmailValidated, "Email format was not validated")
        XCTAssertTrue(mockSignupModelValidator.isPasswordValidated, "Password was not validated")
        XCTAssertTrue(mockSignupModelValidator.isPasswordEqualityValidated, "Did not validate if passwords match")
    }
    
    func testSignupPresenter_WhenGivenValidFormModel_ShouldCallSignupMethod() {
        // Arrange
      
        // Act
        sut.processUserSignup(formModel: signupFormModel)

        // Assert
        XCTAssertTrue(mockSignupWebService.isSignupMethodCalled)
    }
    
    func testSignupPresenter_WhenSignupOperationIsSuccessful_CallsSuccessOnViewDelegate() {
        // Arrange
        let myExpectation = expectation(description: "Expected the successfulSignUp() method to be called")
        mockSignupViewDelegate.expectation = myExpectation
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        self.wait(for: [myExpectation], timeout: 5)
        // Assert
        XCTAssertEqual(mockSignupViewDelegate.successfulSignUpCounter, 1, "Successful signup() was called more than once")
    }
    
    func testSignupPresenter_WhenSignupOperationFails_callsErrorHandlerOnViewDelegate() {
       // Arrange
        let errorHandlerExpectation = expectation(description: "Expected the errorHandler() method to be called")
        mockSignupViewDelegate.expectation = errorHandlerExpectation
        mockSignupWebService.shouldReturnError = true

        // Act
        sut.processUserSignup(formModel: signupFormModel)
        wait(for: [errorHandlerExpectation], timeout: 5)

        // Assert
        XCTAssertEqual(mockSignupViewDelegate.successfulSignUpCounter, 0)
        XCTAssertEqual(mockSignupViewDelegate.errorHandlerCounter, 1)
        XCTAssertNotNil(mockSignupViewDelegate.signupError)


    }

        

}
