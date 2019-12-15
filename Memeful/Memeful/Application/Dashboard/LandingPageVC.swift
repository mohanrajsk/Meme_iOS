//
//  LandingPageVC.swift
//  Memeful
//
//  Created by LKB-L-105 on 13/12/19.
//

import UIKit

class LandingPageVC: UIViewController {

    // MARK: - Varialbles
    var currentPageIndex = 0
    var currentVC: UIViewController!

    // Pages
    var homeVC: HomeVC!
    var searchVC: SearchVC!
    var entertainVC: EntertainVC!
    var notificationsVC: NotificationsVC!
    var profileVC: ProfileVC!
    
    // MARK: - UIElements
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var containerView: UIView!

    // MARK: LyfCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        designTheUI()
    }

    // MARK: Instance Methods
    func designTheUI(){
        
        tabBar.delegate = self
        tabBar.tintColor = UIColor.appThemeColor
        setPage(0)
        
    }

    func setPage(_ index: Int){
        
           if index == 0 {
            
               if homeVC == nil{
                   homeVC = HomeVC(nibName: "HomeVC", bundle: nil)
               }
               add(asChildViewController: homeVC)
            
           }
           else if index == 1 {
            
                if searchVC == nil{
                    searchVC = SearchVC(nibName: "SearchVC", bundle: nil)
                }
                add(asChildViewController: searchVC)
                         
           }
           else if index == 2 {
                
                if entertainVC == nil{
                   entertainVC = EntertainVC(nibName: "EntertainVC", bundle: nil)
                }
                add(asChildViewController: entertainVC)
            
           }
           else if index == 3 {
             
                if notificationsVC == nil{
                    notificationsVC = NotificationsVC(nibName: "NotificationsVC", bundle: nil)
                }
                add(asChildViewController: notificationsVC)
            
           }
           else if index == 4 {
                
                if profileVC == nil{
                    profileVC = ProfileVC(nibName: "ProfileVC", bundle: nil)
                }
                add(asChildViewController: profileVC)
            
           }
           currentPageIndex = index
           tabBar.selectedItem = tabBar.items?[currentPageIndex]
         
       }
    
        func add(asChildViewController viewController: UIViewController) {
           
           // Remove existing VCs from memory
           resetChilds()
           currentVC = viewController
           
           // Add Child View Controller
            addChild(viewController)
           
           // Add Child View as Subview
           containerView.addSubview(viewController.view)
           
           // Configure Child View
           viewController.view.frame = containerView.bounds
           viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           
           // Notify Child View Controller
            viewController.didMove(toParent: self)
           
           print("currentViews : \(containerView.subviews.count)")
       }
       
       func resetChilds() {
       
           if currentVC != nil {
                currentVC.willMove(toParent: nil)
                currentVC.view.removeFromSuperview()
                currentVC.removeFromParent()
           }
           
       }
    
}

extension LandingPageVC: UITabBarDelegate{
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    
        if let index = tabBar.items?.firstIndex(of: item){
            if index != currentPageIndex{
                setPage(index)
            }
        }
        
    }
    
}
