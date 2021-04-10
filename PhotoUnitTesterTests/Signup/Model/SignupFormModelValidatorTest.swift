//
//  SignupFormModelValidator.swift
//  PhotoUnitTesterTests
//
//  Created by George Cremer on 09/04/2021.
//

@testable import PhotoUnitTester
import XCTest

class SignupFormModelValidatorTest: XCTestCase {
    var sut: SignupFormModelValidator!

    override func setUpWithError() throws {
        sut = SignupFormModelValidator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testSignFormModelValidator_WhenValidFirstNameProvided_ShouldReturnTrue() {
        // Arrange
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "Tester")

        // Assert
        XCTAssertTrue(isFirstNameValid, "The isFirstNameValidated() should have returned TRUE for a valid first name but returned FALSE")
    }

    func testSignupFormModelValidator_WhenTooShortFirstNameProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "T")

        // Assert
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValidated() should have returned FALSE for a first name that is shorter than \(SignupConstants.firstNameMinLength) characters but it has returned TRUE")
    }

    func testSignupFormModelValidator_WhenTooLongFirstNameProvided_ShouldReturnFalse() {
        let isFirstNameValid = sut.isFirstNameValid(firstName: "ReallllllyLoooongName")

        XCTAssertFalse(isFirstNameValid, "The isFirstNameValidated() should have returned FALSE for a first name that is longer than \(SignupConstants.firstNameMaxLength) characters but it has returned TRUE")
    }

    // MARK: Last Name Validation Unit Tests

    func testSignFormModelValidator_WhenValidLastNameProvided_ShouldReturnTrue() {
        // Arrange
        // Act
        let isLastNameValid = sut.isLastNameValid(lastName: "Tester")

        // Assert
        XCTAssertTrue(isLastNameValid, "The isLastNameValid() should have returned TRUE for a valid last name but returned FALSE")
    }

    func testSignupFormModelValidator_WhenTooShortLastNameProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isLastNameValid = sut.isLastNameValid(lastName: "T")

        // Assert
        XCTAssertFalse(isLastNameValid, "The isLastNameValid() should have returned FALSE for a last name that is shorter than \(SignupConstants.lastNameMinLength) characters but it has returned TRUE")
    }

    func testSignupFormModelValidator_WhenTooLongLastNameProvided_ShouldReturnFalse() {
        let isLastNameValid = sut.isLastNameValid(lastName: "ReallllllyLoooongName")

        XCTAssertFalse(isLastNameValid, "The isLastNameValid() should have returned FALSE for a last name that is longer than \(SignupConstants.lastNameMaxLength) characters but it has returned TRUE")
    }

    // MARK: Email Address Validation

    func testSignupFormModelValidator_WhenValidEmailProvided_ShouldReturnTrue() {
        let isValidEmailFormat = sut.isValidEmailFormat(email: "tester@test.com")

        XCTAssertTrue(isValidEmailFormat, "Provided valid email address format but validation did not pass")
    }

    func testSignupFormModelValidator_WhenInValidEmailProvided_ShouldReturnFalse() {
        let isValidEmailFormat = sut.isValidEmailFormat(email: "tester@test")

        XCTAssertFalse(isValidEmailFormat, "Provided invalid email address format but validation still passed")
    }

    // MARK: Password Validation

    func testSignupFormModelValidator_WhenValidPasswordProvided_ShouldReturnTrue() {
        // Act
        let isPasswordValid = sut.isPasswordValid(password: "12345678")

        // Assert
        XCTAssertTrue(isPasswordValid, "The isPasswordValid() should have returned TRUE for a valid password  but it has returned FALSE")
    }

    func testSignupFormModelValidator_WhenTooShortPasswordProvided_ShouldReturnFalse() {
        // Act
        let isPasswordValid = sut.isPasswordValid(password: "12")

        // Assert
        XCTAssertFalse(isPasswordValid, "The isPasswordValid() should have returned FALSE for a password that is shorter than \(SignupConstants.passwordMinLength) but it has returned TRUE")
    }

    func testSignupFormModelValidator_WhenTooLongPasswordProvided_ShouldReturnFalse() {
        // Act
        let isPasswordValid = sut.isPasswordValid(password: "12345678901234567")

        // Assert
        XCTAssertFalse(isPasswordValid, "The isPasswordValid() should have returned FALSE for a password that is longer than \(SignupConstants.passwordMaxLength) but it has returned TRUE")
    }

    func testSignupFormModelValidator_WhenEqualPasswordsProvided_ShouldReturnTrue() {
        // Act
        let doPasswordsMatch = sut.doPasswordsMatch(password: "12345678", repeatPassword: "12345678")

        // Assert
        XCTAssertTrue(doPasswordsMatch, "The doPasswordsMatch() should have returned TRUE for matching passwords but it has returned FALSE")
    }

    func testSignupFormModelValidator_WhenNotMatchingPasswordsProvided_ShouldReturnFalse() {
        // Act
        let doPasswordsMatch = sut.doPasswordsMatch(password: "12345678", repeatPassword: "1234678")

        // Assert
        XCTAssertFalse(doPasswordsMatch, "The doPasswordsMatch() should have returned FALSE for passwords that do not match but it has returned TRUE")
    }
}
