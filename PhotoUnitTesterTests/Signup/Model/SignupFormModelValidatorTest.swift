//
//  SignupFormModelValidator.swift
//  PhotoUnitTesterTests
//
//  Created by George Cremer on 09/04/2021.
//

import XCTest
@testable import PhotoUnitTester

class SignupFormModelValidatorTest: XCTestCase {

    var sut: SignupFormModelValidator!

    
    
    override func setUpWithError() throws {
        sut = SignupFormModelValidator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }


    
    func testSignFormModelValidator_WhenValidFirstNameProvided_ShouldReturnTrue(){
        //Arrange
        
        //Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "George")
        
        //Assert
        XCTAssert(isFirstNameValid, "The isFirstNameValid() should have return TRUE for a valid first name but returned FALSE.")
    }
    
    func testSignFormModelValidator_WhenTooShortFirstNameProvided_ShouldReturnFalse() {
        
        //Arrange
        
        //Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "S")
        
        //Assert
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should have return FALSE for a first name that is shorter than \(SignupConstants.firstNameMinimumLength) characters, but has returned TRUE.")
        
    }
    
    func testSignFormModelValidator_WhenTooLongFirstNameProvided_ShouldReturnFalse() {
        let isFirstNameValid = sut.isFirstNameValid(firstName: "LooooooooongName")
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should have return FALSE for a first name that is longer than \(SignupConstants.firstNameMaximumLength) characters, but has returned TRUE.")
    }
    
    func testSignFormModelValidator_WhenEqualPasswordsProvided_ShouldReturnTrue() {
        let doPasswordsMatch = sut.doPasswordsMatch(password: "123456",repeatPassword: "123456")
        XCTAssert(doPasswordsMatch, "doPasswordsMatch() should have returned TRUE for matching passwords, but has returned FALSE")
    }
    
    func testSignFormModelValidator_WhenNotEqualPasswordsProvided_ShouldReturnFalse() {
        let doPasswordsMatch = sut.doPasswordsMatch(password: "123456",repeatPassword: "wrong")
        XCTAssertFalse(doPasswordsMatch, "doPasswordsMatch() should have returned FALSE for not matching passwords, but has returned TRUE")
    }

        

}
