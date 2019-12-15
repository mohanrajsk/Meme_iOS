//
//  HomePresenter.swift
//  Memeful
//
//  Created by LKB-L-105 on 13/12/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//
// This file Contains methods to make changes in the View/UI
//

import UIKit

class HomePresenter: Presenter
{

    var dashboardVC: HomeVC? { return controller as? HomeVC }
    
    // Present Profile info
    func presentResponse(response: Home.Response) {
      
        dashboardVC?.presentResponse(response: response)

    }

}
