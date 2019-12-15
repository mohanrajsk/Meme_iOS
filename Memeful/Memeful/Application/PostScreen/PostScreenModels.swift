//
//  PostScreenModels.swift
//  Memeful
//
//  Created by LKB-L-105 on 13/12/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//
// Models / ViewModels available for PostScreen
//

import UIKit

enum PostScreen
{
    // MARK: Use cases
    struct Request {
        
        var postID: String?
        
    }
    
    // MARK: Dashboard - Response
    struct Response {
        
       var postDetails: [[String:Any]]?
       var comments: [Model.Comment]?
       var error: String?
        
    }
    
    // MARK: Codable Models
    struct Model: Codable {
    
        // API Response Model
        var result: [Comment]?
        enum CodingKeys: String, CodingKey {
            case result = "data"
        }
            
        // Feed Model
        struct Comment: Codable {
           
           var commentId: Int?
           var author: String?
           var comment: String?
           var ups: Int?
           var downs: Int?
           var timeStamp: Double?
           var replies: [Comment]?
           
           enum CodingKeys: String, CodingKey {
            
             case commentId = "id"
             case author = "author"
             case comment
             case ups = "ups"
             case downs = "downs"
             case timeStamp = "datetime"
             case replies = "children"

            }
           
        }
    }
    
}
