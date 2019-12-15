//
//  PostsVC.swift
//  Memeful
//
//  Created by LKB-L-105 on 15/12/19.
//

import UIKit

class PostsVC: UIPageViewController {
    
    // MARK: Variables
    var feeds: [Home.Model.Feed]?
    var feedIndex: Int! = 0
    
    // MARK: LyfCycle Methods
    override func viewDidLoad() {
        
        self.dataSource = self
        let controller = createViewController(index: feedIndex)
        self.setViewControllers([controller], direction: .forward, animated: false, completion: nil)
        
    }
    
    // MARK: Instance Methods
    func createViewController(index: Int) -> UIViewController {
        
        let currentIndex = index >= 0 ? index : 0
        let controller = PostScreenVC.init(nibName: "PostScreenVC", bundle: nil)
        controller.feeds = feeds
        controller.feedIndex = currentIndex
        return controller
        
    }
    
}

extension PostsVC: UIPageViewControllerDataSource {
    
    // Show Previous Page
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        feedIndex = feedIndex - 1
        let controller = createViewController(index: feedIndex)
        return controller
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        feedIndex = feedIndex + 1
        let controller = createViewController(index: feedIndex)
        return controller
        
    }
    
}

