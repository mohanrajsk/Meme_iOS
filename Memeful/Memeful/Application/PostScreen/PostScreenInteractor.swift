//
//  PostScreenInteractor.swift
//  Memeful
//
//  Created by LKB-L-105 on 13/12/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file contains user interaction / business logic.
//

import UIKit

class PostScreenInteractor: Interactor
{

  // Presenter Instance
  weak var presenterInstance: PostScreenPresenter? { return presenter as? PostScreenPresenter }

  // Load Comments from API
  func loadComments(request: PostScreen.Request) {
        
    APIWorker.loadComments(postID: request.postID ?? "") {[weak self] (data, error) in
        
        if let error = error {
           self?.presenterInstance?.presentResponse(response: PostScreen.Response(comments: nil, error: error))
       }
       else {

           do {
               
               let model: PostScreen.Model = try JSONDecoder().decode(PostScreen.Model.self, from: data!)
               self?.presenterInstance?.presentResponse(response: PostScreen.Response(comments: model.result, error: nil))
               print(model)
               
           }
           catch let error {
                print(error)
               self?.presenterInstance?.presentResponse(response: PostScreen.Response(comments: nil, error: parseError))
           }
            
       }
        
    }
    
  }
    
}
