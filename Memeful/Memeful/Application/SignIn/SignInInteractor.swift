//
//  SignInInteractor.swift
//  Memeful
//
//  Created by LKB-L-105 on 13/12/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file contains user interaction / business logic.
//

import UIKit

class SignInInteractor: Interactor
{

    // Presenter Instance
    weak var presenterInstance: SignInPresenter? { return presenter as? SignInPresenter }

    // API - SignIn
    func signIn(request: SignIn.Request) {
        
        if validate(request: request) {

            if request.email == "task@gmail.com" && request.password == "12345678" {

                let response = SignIn.Response(status: "Success", error: nil)
                self.presenterInstance?.presentSignInResponse(output: response)

            }
            else {
                let response = SignIn.Response(status: nil, error: "Authentication failed")
                self.presenterInstance?.presentSignInResponse(output: response)

            }
        }
        
    }
    
}

// MARK: Validations
extension SignInInteractor {
     
     // Perform Validation for Normal SignIn
     func validate(request: SignIn.Request) -> Bool {
        
        if let result = UtilsManager.validateInputField(fieldValue: request.email, fieldName: SignIn.Required.Email.placeholder, minLength: EMAIL_MIN, maxLength: EMAIL_MAX, isEmail: true) {
            
            presenterInstance?.presentSignInValidationResult(validationMessage: result, field: SignIn.Required.Email)
            return false
            
        }
        else if let result = UtilsManager.validateInputField(fieldValue: request.password, fieldName: SignIn.Required.Password.placeholder, minLength: PASSWORD_MIN, maxLength: PASSWORD_MAX, isEmail: false) {
            
            presenterInstance?.presentSignInValidationResult(validationMessage: result, field: SignIn.Required.Email)
            return false
            
        }
        return true
        
     }
    
}
