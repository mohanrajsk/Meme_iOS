//
//  VIPERObjects.swift
//
//  Copyright © 2019 Lakeba. All rights reserved.
//

import UIKit

// MARK: Interactor
// Contains user interaction / business logic.
class Interactor: NSObject {
    
    // Presenter is used to update view after interactor alters data
    weak var presenter: Presenter?
   
    // Router is used for navigation based on actions taken
    weak var router: Router?
    
    required override init() {
        super.init()
    }
}

// MARK: Interactor
// Contains objects to make changes in the U
class Presenter: NSObject {
    
    // Should contain view configuration/change logic
    weak var controller: UIViewController?
    
    // Interactor is provided as a delegate for any actions from views
    weak var interactor: Interactor?
    
    required override init() {
        super.init()
    }
}

// MARK: Router
// Contains navigation logics
class Router: NSObject {
    
    // To identify the current view controller
    weak var controller: UIViewController?
    
    // To Get the Navigation conroller from Router
    lazy var navController: UINavigationController? = { [weak self] in
        return self?.controller?.navigationController
    }()
    
    required override init() {
        super.init()
    }
    
}
