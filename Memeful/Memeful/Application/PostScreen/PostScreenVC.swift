//
//  PostScreenVC.swift
//  Memeful
//
//  Created by LKB-L-105 on 13/12/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// To Choose TableView Cell Dynamically
enum PostCellType : Int {
    
    case Title = 0
    case Image
    case Video
    case Tags
    case Comments
    
}

class PostScreenVC: UIViewController
{
    
    // MARK: UIElements
    @IBOutlet weak var tableView: UITableView!
    
    // MARK : Variables
    var feeds: [Home.Model.Feed]?
    var feedIndex: Int! = 0
    var loader: MBProgressHUD?
    var postData: [[String:Any]] = []
    
    // MARK : UIElements
    @IBOutlet weak var vwPostOptions: PostOptionsView!
    
    // MARK : Build Viper Architecture via Manager
    lazy var viperManager: VIPERManager <PostScreenInteractor, PostScreenPresenter, PostScreenRouter> = {
        return VIPERManager(forController: self)
    }()
    
    // MARK: View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        buildUI()
    }
    
    override func viewDidLayoutSubviews() {
        vwPostOptions.setAsCardView()
    }
    
    // MARK : Instance Methods
    func buildUI() {
        
        // Table View
        tableView.register(UINib.init(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        tableView.register(UINib.init(nibName: "PhotoCell", bundle: nil), forCellReuseIdentifier: "PhotoCell")
        tableView.register(UINib.init(nibName: "TagsCell", bundle: nil), forCellReuseIdentifier: "TagsCell")
        tableView.register(UINib.init(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
        tableView.tableFooterView = UIView()
        
        // Load Comments for the selected Post
        loadComments()
        
    }
    
    func loadComments() {
        
        if let feeds = feeds {
            
           let feedItem = feeds[feedIndex]
           let input = PostScreen.Request(postID: feedItem.feedId)
           loader = UtilsManager.getLoader(onView: self.view)
           viperManager.interactor.loadComments(request: input)
           vwPostOptions.renderInfo(up: feedItem.upVotes ?? 0, down: feedItem.downVotes ?? 0, favour: feedItem.favourCount ?? 0)
            
        }
        
    }
    
    func displayPostDetail(postDetails: [[String : Any]]){
        
        self.postData = postDetails
        tableView.reloadData()
        
    }
 
    // MARK: UIActions
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: TableView Delegates
extension PostScreenVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let metaData = postData[indexPath.row]
        let cellType = PostCellType(rawValue: metaData["cellType"] as! Int)
            
            switch cellType {
        
                case .Title:
                        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
                        cell.renderHeaderInfo(info: metaData)
                        cell.selectionStyle = .none;
                        return cell
                
                case .Image,.Video:
                        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
                        cell.renderInfo(info: metaData)
                        cell.selectionStyle = .none;
                        return cell
                
                case .Tags:
                        let cell = tableView.dequeueReusableCell(withIdentifier: "TagsCell", for: indexPath) as! TagsCell
                        cell.renderInfo(info: metaData)
                        cell.selectionStyle = .none;
                        return cell
                    
                case .Comments:
                        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
                        cell.renderInfo(info: metaData)
                        cell.selectionStyle = .none;
                        return cell
                
                case .none: break
            
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        let metaData = postData[indexPath.row]
        let cellType = PostCellType(rawValue: metaData["cellType"] as! Int)
        
        if cellType == PostCellType.Image {
         
            if let width = metaData["width"] as? Int,  let height = metaData["height"] as? Int {
                let widthRatio = CGFloat(width) / CGFloat(height)
                return tableView.frame.width * widthRatio
            }
            
        }
        
        return UITableView.automaticDimension
        
    }
        
}

// MARK: Implement - VIPER's Presenter Delegates
extension PostScreenVC {
    
    // Present post response
    func presentResponse(response: PostScreen.Response) {
        
        UtilsManager.hideLoader(loader)
        if let error = response.error {
            UtilsManager.showAlertMessage(message: error)
        }
        else {
            
            DispatchQueue.main.async {
                self.displayPostDetail(postDetails: response.postDetails ?? [[:]])
            }
            
        }
        
        
    }
    
}
