//
//  SignupViewControllerTests.swift
//  PhotoUnitTesterTests
//
//  Created by George Cremer on 10/04/2021.
//

import XCTest
@testable import PhotoUnitTester


class SignupViewControllerTests: XCTestCase {

    var storyboard: UIStoryboard!
    var sut: SignupViewController!
    
    override func setUpWithError() throws {
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "SignupViewController") as? SignupViewController
        sut.loadViewIfNeeded()
        
    }

    override func tearDownWithError() throws {
        storyboard = nil
        sut = nil
    }

    func testSignupViewController_WhenCreated_HasRequiredTextFieldsEmpty() throws {
        // Arrange
        let firstNameTextField = try XCTUnwrap(sut.firstNameTextfield, "The firstNameTextField is not connected to an IBOutlet")
        let lastNameTextField = try XCTUnwrap(sut.lastNameTextfield, "The lastNameTextField is not connected to an IBOutlet")
        let emailTextField = try XCTUnwrap(sut.emailTextfield, "The emailTextField is not connected to an IBOutlet")
        let passwordTextField = try XCTUnwrap(sut.passwordTextfield, "The passwordTextField is not connected to an IBOutlet")
        let repeatPasswordTextField = try XCTUnwrap(sut.repeatPasswordTextfield, "The repeatPasswordTextField is not connected to an IBOutlet")
        
        // Act
        
        
        // Assert
        XCTAssertEqual(firstNameTextField.text, "", "First name text field was not empty when the view controller initially loaded")
        XCTAssertEqual(lastNameTextField.text, "", "Last name text field was not empty when the view controller initially loaded")
        XCTAssertEqual(emailTextField.text, "", "Email text field was not empty when the view controller initially loaded")
        XCTAssertEqual(passwordTextField.text, "", "Password text field was not empty when the view controller initially loaded")
        XCTAssertEqual(repeatPasswordTextField.text, "", "Repeat Password text field was not empty when the view controller initially loaded")
    }
    
    func testSignupViewController_WhenCreated_HasSignupButtonAndAction() throws {
       // Arrange
        let signupButton: UIButton = try XCTUnwrap(sut.signupButton,"signupButton is not does not have a referencing outlet")
        
        // Act
        let signupButtonActions = try XCTUnwrap(signupButton.actions(forTarget: sut, forControlEvent: .touchUpInside),"signupButton is not attached to an action")
        
        // Assert
        XCTAssertEqual(signupButtonActions.count, 1)
        XCTAssertEqual(signupButtonActions.first, "signupButtonPressed:", "There is no action with the name signupButtonPressed: assigned to the signup button")
    }
    
    func testSignupViewController_WhenSignupButtonTapped_InvokesSignupProcess()  {
        // Arrange
        let mockSignupModelValidator = MockSignupModelValidator()
        let mockWebService = MockSignupWebService()
        let mockSignupViewDelegate = MockSignupViewDelegate()
        
        let mockSignupPresenter = MockSignupPresenter(formModelValidator: mockSignupModelValidator, webService: mockWebService, delegate: mockSignupViewDelegate)
        
        sut.signupPresenter = mockSignupPresenter
        // Act
        sut.signupButton.sendActions(for: .touchUpInside)
        
        // Assert
        XCTAssertTrue(mockSignupPresenter.processUserSignupCalled, "The processUserSignup() method was not called on a Presenter object when the signup button was tapped in a SignupViewController")
    }
}
