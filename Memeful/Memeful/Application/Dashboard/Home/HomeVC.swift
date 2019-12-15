//
//  HomeVC.swift
//  Memeful
//
//  Created by LKB-L-105 on 13/12/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import AVFoundation

class HomeVC: UIViewController
{
    
    // MARK: Variables
    var loader: MBProgressHUD?
    var feeds: [Home.Model.Feed] = []
    var filterView: FilterView!
    var input = Home.Request()
    var currentCompletionHandler: (()->Void)? = nil
    
    // MARK: UIElements
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var headerView: HeaderView!
    
    // MARK: Build Viper Architecture via Manager
    lazy var viperManager: VIPERManager <HomeInteractor, HomePresenter, HomeRouter> = {
        return VIPERManager(forController: self)
    }()
    
    // MARK: View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initialize()
    }
    
    // MARK: Instance Methods
    func initialize() {
        
        // Init HeaderView
        headerView.setTitle("Most Viral")
        headerView.setRightButtonTitle("")
        headerView.delegate = self
        
        // Init Collection View
        collectionView.register(UINib.init(nibName: "GridCell", bundle: nil), forCellWithReuseIdentifier: "GridCell")
        collectionView?.backgroundColor = .clear
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        // Load Custom Flow Layout
        if let layout = collectionView?.collectionViewLayout as? GridLayout {
            layout.delegate = self
        }
        
        // Init Filter View
        filterView = FilterView()
        filterView.frame = CGRect(x: 15, y: headerView.bounds.size.height, width: 300, height: 180)
        filterView.delegate = self
        filterView.chooseByIndex(index: 0)
        
        initInfiniteScroll()
        
    }
    
    // MARK: APIs
    func loadDashboard(apiLoadOptions: Home.APILoadOptions) {
        
        switch apiLoadOptions{
            
        case .none:
            loader = UtilsManager.getLoader(onView: self.view)
            input.page = 0
            
        case .pullDownRefresh:
            input.page = 0
            
        case .loadMore:
            input.page = input.page + 1
            
        }
        viperManager.interactor.loadDashboard(request: input)
        
    }
    
}

// MARK: HeaderView & FilterView - Delegate
extension HomeVC: HeaderViewDelegate, FilterViewDelegate, UIGestureRecognizerDelegate {
    
    func receiveFilterEvent(index: Int) {
        
        let selectedFilterOptions: Home.HomeFilterOptions = Home.HomeFilterOptions(rawValue: index) ?? Home.HomeFilterOptions.MostViral_Popular
        
        if input.filterOption != selectedFilterOptions{
            
            input.filterOption = selectedFilterOptions
            input.page = 0
            loadDashboard(apiLoadOptions: .none)
            
        }
        
    }
    
    func didLeftButtonClicked() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTapOffModal(_:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        self.view.isUserInteractionEnabled = true
        self.collectionView.isUserInteractionEnabled = false
        self.view.addSubview(filterView)
        
    }
    
    func didRightButtonClicked() { }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        self.filterView.removeFromSuperview()
        self.collectionView.isUserInteractionEnabled = true
        return touch.view == gestureRecognizer.view
        
    }
    
    @objc func handleTapOffModal(_ sender: UITapGestureRecognizer) {
        filterView.removeFromSuperview()
    }
    
}

// MARK: Collection View - Delegate & Data Source
extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, GridLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath as IndexPath) as! GridCell
        cell.feed = feeds[indexPath.item]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
        
    }
    
    // MARK: Show Post Screen - OnClick
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        viperManager.router.showPostScreen(index: indexPath.row, feeds: self.feeds)
        
    }
    
    // MARK: CollectionView Layout Design - GridLayoutDelegate
    func collectionView(collectionView: UICollectionView, heightForPhotoAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        
        var size = CGSize.init(width: CGFloat(MAXFLOAT), height: 1)
        let feed = feeds[indexPath.row]
        
        if let feedHeight = feed.feedHeight, let feedWidth = feed.feedWidth {
            
            size = CGSize.init(width: CGFloat(feedWidth), height:  CGFloat(feedHeight))
            let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
            let rect  = AVMakeRect(aspectRatio: size, insideRect: boundingRect)
            return rect.size.height > 200 ? rect.size.height : 200.0
            
        }
        
        return 200.0
        
    }
    
}

// MARK: Implement - VIPER's Presenter Delegates
extension HomeVC {
    
    // Present dashboard response
    func presentResponse(response: Home.Response) {
        
        if let error = response.error {
            UtilsManager.showAlertMessage(message: error)
        }
        else {
            
            DispatchQueue.main.async { [weak self] in
                
                self?.feeds = response.feeds ?? []
                self?.collectionView.reloadData()
                UtilsManager.hideLoader(self?.loader)
                
                if let unwrappedRefreshCompletion = self?.currentCompletionHandler {
                    unwrappedRefreshCompletion()
                }
            }
            
        }
        
    }
    
    
}

// MARK: Pull Down & Load More
extension HomeVC: KRPullLoadViewDelegate {
        
    func initInfiniteScroll()
    {
        
       let refreshView = KRPullLoadView()
       refreshView.delegate = self
       refreshView.activityIndicator.color = UIColor.white
       refreshView.messageLabel.textColor = UIColor.white
       collectionView.addPullLoadableView(refreshView, type: .refresh)
       
       let loadMoreView = KRPullLoadView()
       loadMoreView.delegate = self
       loadMoreView.activityIndicator.color = UIColor.white
       loadMoreView.messageLabel.textColor = UIColor.white
       collectionView.addPullLoadableView(loadMoreView, type: .loadMore)
        
    }
    
    func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        
        if type == .loadMore {
            
            switch state {
                
            case let .loading(completionHandler):
                
                self.currentCompletionHandler = completionHandler
                input.loadOption = .loadMore
                self.loadDashboard(apiLoadOptions: .loadMore)
                
            default: break
                
            }
            
            return
        }
        
        
        if type == .refresh {
            
            switch state {
                
            case let .loading(completionHandler):
                
                self.currentCompletionHandler = completionHandler
                input.loadOption = .pullDownRefresh
                self.loadDashboard(apiLoadOptions: .pullDownRefresh)
                
            default: break
                
            }
            
            return
        }
        
        switch state {
            
        case .none:
            pullLoadView.messageLabel.text = ""
            
        case let .pulling(offset, threshould):
            
            if offset.y > threshould {
                pullLoadView.messageLabel.text = "Pull more to refresh"
            } else {
                pullLoadView.messageLabel.text = "Release to refresh"
            }
            
        case let .loading(completionHandler):
            
            pullLoadView.messageLabel.text = "Loading..."
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                
                completionHandler()
                self.collectionView.reloadData()
                self.loadDashboard(apiLoadOptions: .loadMore)
                
            }
            
        }
    }
    
}

