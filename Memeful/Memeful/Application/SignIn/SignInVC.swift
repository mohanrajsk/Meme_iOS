//
//  SignInVC.swift
//  Memeful
//
//  Created by LKB-L-105 on 13/12/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class SignInVC: UIViewController
{
    
    // MARK : Variables
    var loader: MBProgressHUD?
    
    // MARK : UIElements
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    // MARK : Build Viper Architecture via Manager
    lazy var viperManager: VIPERManager <SignInInteractor, SignInPresenter, SignInRouter> = {
        return VIPERManager(forController: self)
    }()
    
    // MARK: View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        buildUI()
    }
    
    // MARK : Instance Methods
    func buildUI()
    {
        btnLogin.setAsSmoothCorner()
    }
    
    func clear() {
        
        // Reset UI
        self.view.endEditing(true)
        txtPassword.text = ""
        txtEmail.text = ""
        
    }
    
    // MARK: UIActions
    @IBAction func signIn(_ sender: Any) {
        
        self.view.closeKeyboard()
        
        var inputRequest = SignIn.Request()
        inputRequest.email = txtEmail.text!
        inputRequest.password = txtPassword.text!
        performSignIn(inputRequest: inputRequest)
        
    }
 
    func performSignIn(inputRequest: SignIn.Request) {
         
         loader = UtilsManager.getLoader(onView: self.view)
         viperManager.interactor.signIn(request: inputRequest)
         
     }
    
}

// MARK: Implement - VIPER's Presenter Delegates
extension SignInVC {
    
    // Handle Validation Result
    func presentValidationResult(validationMessage: String, field: SignIn.Required) {
        
        UtilsManager.hideLoader(loader)
        UtilsManager.sendValidationFailed(message: validationMessage)
        
    }
    
    // Handle SignIn Response
    func presentSignInResponse(response: SignIn.Response) {
        
        UtilsManager.hideLoader(loader)
        if let error = response.error {
            
            UtilsManager.showAlertMessage(message: error)
            
        }
        else {
            
            // Show Home Page
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: LOGGED_IN)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.launchRootViewController()
            
        }
        
    }
    
}
