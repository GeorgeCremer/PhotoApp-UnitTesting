//
//  SignupViewController.swift
//  PhotoUnitTester
//
//  Created by George Cremer on 10/04/2021.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet var firstNameTextfield: UITextField!
    @IBOutlet var lastNameTextfield: UITextField!
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var repeatPasswordTextfield: UITextField!
    @IBOutlet var signupButton: UIButton!

    var signupPresenter: SignupPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if signupPresenter == nil {
            let signupModelValidator = SignupFormModelValidator()
            let webService = SignupWebService(urlString: SignupConstants.signupURLString)
            
            signupPresenter = SignupPresenter(formModelValidator: signupModelValidator,
                                              webService: webService,
                                              delegate: self)
        }
    
    }
    
    @IBAction func signupButtonPressed(_ sender: UIButton) {
        let signUpFormModel = SignupFormModel(firstName: firstNameTextfield.text ?? "",
                                              lastName: lastNameTextfield.text ?? "",
                                              email: emailTextfield.text ?? "",
                                              password: passwordTextfield.text ?? "",
                                              repeatPassword: repeatPasswordTextfield.text ?? "")
        
        signupPresenter?.processUserSignup(formModel: signUpFormModel)
    }
    

}

extension SignupViewController: SignupViewDelegateProtocol {
    func successfulSignUp() {
        // Todo
    }
    
    func errorHandler(error: SignupError) {
        // Todo

    }
    
    
}
