//
//  VIPERManager.swift
//
//  Copyright © 2019 Lakeba. All rights reserved.
//

import UIKit

class VIPERManager <I: Interactor, P: Presenter, R: Router>: NSObject {
    
    public let interactor: I
    // Declared as private for restrict presenter usage in ViewController
    private let presenter: P
    public let router: R
    
    public init(forController: UIViewController, interactor: I = I(), presenter: P = P(), router: R = R()) {
        
        self.interactor = interactor
        self.presenter = presenter
        self.router = router
        super.init()
        
        VIPERManager.setupVIPER(controller: forController, interactor: interactor, presenter: presenter, router: router)
        
    }
    
    static func setupVIPER(controller: UIViewController, interactor: Interactor, presenter: Presenter, router: Router) {
        
        // Set Presenter Properties
        presenter.interactor = interactor
        presenter.controller = controller
        
        // Set Interactor properties
        interactor.presenter = presenter
        interactor.router = router
        
        // Set Router Properties
        router.controller = controller
        
    }
    
}

