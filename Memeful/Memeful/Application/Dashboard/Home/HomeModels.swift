//
//  HomeModels.swift
//  Memeful
//
//  Created by LKB-L-105 on 13/12/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//
// Models / ViewModels available for Home
//

import UIKit

enum Home
{
    
    // MARK: Request Models
    struct Request {
        var page: Int = 0
        var filterOption: HomeFilterOptions = .MostViral_Newest
        var loadOption: APILoadOptions = .none
    }
    
    public enum APILoadOptions
    {
        case none
        case pullDownRefresh
        case loadMore
    }


    public enum HomeFilterOptions: Int
    {
        case MostViral_Popular = 0
        case MostViral_Random
        case MostViral_Newest
        case UserSubmittedNewest_Popular
        case UserSubmittedNewest_Rising
        case UserSubmittedNewest_Newest
        
        func getURL() -> String{
            
            switch self {
                
            case .MostViral_Popular:
                return MOST_VIRAL_POPUPAR_API
            case .MostViral_Random:
                return MOST_VIRAL_RANDOM_API
            case .MostViral_Newest:
                return MOST_VIRAL_NEWEST_API
            case .UserSubmittedNewest_Popular:
                return USER_SUBMITTED_POPUPAR_API
            case .UserSubmittedNewest_Rising:
                return USER_SUBMITTED_RISING_API
            case .UserSubmittedNewest_Newest:
                return USER_SUBMITTED_NEWEST_API
            }
            
        }
    }

                
    // MARK: Response Models
    struct Response {
        
       var feeds: [Model.Feed]?
       var error: String?
        
    }
    
        
    // MARK: Codable Models
    struct Model: Codable {
    
        // API Response Model
        var result: [Feed]?
        enum CodingKeys: String, CodingKey {
            case result = "data"
        }
            
        // Feed Model
        struct Feed: Codable {
           
           var feedId: String?
           var title: String?
           var timeStamp: Double?
           var postBy: String?
           var upVotes: Int?
           var downVotes: Int?
           var favourCount: Int?
           var medias: [Media]?
           var feedURL: String?
           var feedHeight: Int?
           var feedWidth: Int?
           var tags: [Tag]?
           var views: Int?
            
           enum CodingKeys: String, CodingKey {
            
             case feedId = "id"
             case title
             case tags
             case timeStamp = "datetime"
             case postBy = "account_url"
             case upVotes = "ups"
             case feedURL = "link"
             case favourCount = "favorite_count"
             case downVotes = "downs"
             case medias = "images"
             case feedHeight = "cover_width"
             case feedWidth = "cover_height"
             case views
            
           }
           
        }

        // Media Model - Video | Image
        struct Media: Codable {
           
           var mediaId: String?
           var description: String?
           var url: String?
           var videoUrl: String?
           var height: Int?
           var width: Int?
           
           enum CodingKeys: String, CodingKey {
            
               case mediaId = "id"
               case description = "description"
               case url = "link"
               case videoUrl = "mp4"
               case height = "height"
               case width = "width"
            
           }
           
        }
        
        // Tag Model
        struct Tag: Codable {
           
           var displayName: String?
           
           enum CodingKeys: String, CodingKey {
            
                case displayName = "display_name"
            
           }
            
        }
        
    }
   
}
