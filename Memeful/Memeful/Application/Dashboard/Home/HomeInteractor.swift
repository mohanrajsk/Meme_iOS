//
//  HomeInteractor.swift
//  Memeful
//
//  Created by LKB-L-105 on 13/12/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file contains user interaction / business logic.
//

import UIKit

class HomeInteractor: Interactor
{

  // Presenter Instance
  weak var presenterInstance: HomePresenter? { return presenter as? HomePresenter }

  // Load Dashboard
  func loadDashboard(request: Home.Request) {
        
    APIWorker.loadDashboard(request: request) {[weak self] (data, error) in
    
        if let error = error {
            self?.presenterInstance?.presentResponse(response: Home.Response(feeds: nil, error: error))
        }
        else {

            do {
                let model: Home.Model = try JSONDecoder().decode(Home.Model.self, from: data!)
                self?.presenterInstance?.presentResponse(response: Home.Response(feeds: model.result, error: nil))
                print(model)
            }
            catch let parsingError {
                print("Error", parsingError)
                self?.presenterInstance?.presentResponse(response: Home.Response(feeds: nil, error: parseError))
            }
            
        }
        
    }
    
  }
    
}
