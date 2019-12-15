//
//  SignInModels.swift
//  Memeful
//
//  Created by LKB-L-105 on 13/12/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//
// Models / ViewModels available for SignIn
//

import UIKit

enum SignIn
{
    
    enum Required :Equatable {
        
        case Email
        case Password
        
        var placeholder: String {
            
            switch self {
                case .Email: return "Email"
                case .Password: return "Password"
            }
            
        }
        
    }
    
    struct Request {
        var email: String!
        var password: String!
    }
    
    
    // MARK: SignIn - Response
    struct Response {
        var status: String?
        var error: String?
    }
    
}
