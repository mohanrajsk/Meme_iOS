//
//  SignInPresenter.swift
//  Memeful
//
//  Created by LKB-L-105 on 13/12/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//
// This file Contains methods to make changes in the View/UI
//

import UIKit

class SignInPresenter: Presenter
{
 
  // SignIn Controller
  var signInController: SignInVC? { return controller as? SignInVC }
  
  func presentSignInResponse(output: SignIn.Response) {
      signInController?.presentSignInResponse(response: output)
  }
  
  func presentSignInValidationResult(validationMessage: String, field: SignIn.Required) {
      signInController?.presentValidationResult(validationMessage: validationMessage, field: field)
  }
  
    
}
