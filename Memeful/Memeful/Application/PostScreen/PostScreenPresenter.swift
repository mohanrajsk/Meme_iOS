//
//  PostScreenPresenter.swift
//  Memeful
//
//  Created by LKB-L-105 on 13/12/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//
// This file Contains methods to make changes in the View/UI
//

import UIKit

class PostScreenPresenter: Presenter
{
 
   var postScreenVC: PostScreenVC? { return controller as? PostScreenVC }
     
     // Present Profile info
     func presentResponse(response: PostScreen.Response) {
       
        buildPostDetailsWithComments(response: response)

     }

    // Build Post Details with comment and display the result in tableview
    func buildPostDetailsWithComments(response: PostScreen.Response) {
        
        var postData = [[String:Any]]()
        if let items = postScreenVC?.feeds {
            
            if items.count > 0 {
            
                let  feedInfo: Home.Model.Feed = items[postScreenVC?.feedIndex ?? 0]
                
                // Type 1: Post Header
                var titleInfo = [String:Any]()
                
                titleInfo["feedID"] = feedInfo.feedId
                titleInfo["title"] = feedInfo.title
                titleInfo["cellType"] = PostCellType.Title.rawValue
                titleInfo["postBy"] = feedInfo.postBy
                titleInfo["timeStamp"] = feedInfo.timeStamp
                
                postData.append(titleInfo)
                
                // Type 2: Post Media - Video / Image
                if let medias = feedInfo.medias {
                    
                    for item in medias {
                        
                        var mediaInfo = [String:Any]()
                        
                        mediaInfo["mediaID"] = item.mediaId
                        mediaInfo["description"] = item.description
                        mediaInfo["url"] = item.url
                        mediaInfo["videoUrl"] = item.videoUrl
                        mediaInfo["height"] = item.height
                        mediaInfo["width"] = item.width
                        
                        if item.videoUrl != nil{
                            mediaInfo["cellType"] = PostCellType.Video.rawValue
                        }
                        else{
                            mediaInfo["cellType"] = PostCellType.Image.rawValue
                        }
                        postData.append(mediaInfo)
                        
                    }
                    
                }
                // Handle - Some times images are not present
                else if let url = feedInfo.feedURL{
                    
                    var mediaInfo = [String:Any]()
                    mediaInfo["cellType"] = PostCellType.Image.rawValue
                    mediaInfo["url"] = url
                    postData.append(mediaInfo)

                }
                
                
                // Type 3: Post Tags
                var tagInfo = [String:Any]()
                
                tagInfo["views"] = feedInfo.views
                tagInfo["cellType"] = PostCellType.Tags.rawValue
                
                if let tags = feedInfo.tags {
                    
                    var tagValues = [String]()
                    for tag in tags {
                        tagValues.append((tag.displayName ?? ""))
                    }
                    
                    tagInfo["tags"] = tagValues

                }
                
                postData.append(tagInfo)
                
                // Type 4: Post Comments
                var comment = [String:Any]()
                
                if let items = response.comments {
                    for item in items {
                        
                        comment["commentId"] = item.commentId
                        comment["author"] = item.author
                        comment["comment"] = item.comment
                        comment["ups"] = item.ups
                        comment["downs"] = item.downs
                        comment["timeStamp"] = item.timeStamp                        
                        comment["repliesCount"] = item.replies?.count
                        comment["cellType"] = PostCellType.Comments.rawValue
                        
                        postData.append(comment)
                        
                    }
                }
                
            }
            
        }
        
        // present data to display comments
        postScreenVC?.presentResponse(response: PostScreen.Response(postDetails: postData, error: response.error))

    }
    
}
