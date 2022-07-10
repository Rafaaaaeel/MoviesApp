//
//  MoviesUITests.swift
//  MoviesUITests
//
//  Created by Rafael Oliveira on 07/07/22.
//

import XCTest

class MoviesUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func registerTheUser_and_sendToDatabase_inFirebase_shouldReturnTrue() throws {
        let app = XCUIApplication()
        app.launch()

        let usernameTextField = app.textFields["Name"]
        XCTAssertTrue(usernameTextField.exists)
        
        usernameTextField.tap()
        usernameTextField.typeText("Rafael1")
        
        let emailTextField = app.textFields["E-mail"]
        XCTAssertTrue(emailTextField.exists)
        
        emailTextField.tap()
        emailTextField.typeText("rafaelo1@icloud.com")
        
        let passwordTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        
        passwordTextField.tap()
        passwordTextField.typeText("@Ovelha10")
        
        let confirmPasswordTextField = app.secureTextFields["Confirm Password"]
        XCTAssertTrue(confirmPasswordTextField.exists)
        
        confirmPasswordTextField.tap()
        confirmPasswordTextField.typeText("@Ovelha10")
        
        let button = app.buttons["Sign up"]
        XCTAssertTrue(button.exists)
        
//        let accountLabel = app.staticTexts["Welcome"]
//        XCTAssertTrue(accountLabel.exists)
        
        button.tap()
    }

}
