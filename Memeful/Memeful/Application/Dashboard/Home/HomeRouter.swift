//
//  HomeRouter.swift
//  Memeful
//
//  Created by LKB-L-105 on 13/12/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//
// Takes care for the transition and passing data between view controllers.
//

import UIKit

class HomeRouter: Router
{
     
    // Show Post Pages
    func showPostScreen(index: Int, feeds: [Home.Model.Feed]){
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let postsScreen: PostsVC = storyboard.instantiateViewController(identifier: "PostsVC") as! PostsVC
        postsScreen.feeds = feeds
        postsScreen.feedIndex = index
        self.navController?.pushViewController(postsScreen, animated: true)
        
    }

}
