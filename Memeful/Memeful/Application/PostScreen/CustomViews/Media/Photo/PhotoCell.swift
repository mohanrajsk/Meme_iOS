//
//  PhotoCell.swift
//  Memeful
//
//  Created by LKB-L-105 on 14/12/19.
//

import UIKit
import WebKit
import AVFoundation

class PhotoCell: UITableViewCell {
    
    // MARK: UIElements
    @IBOutlet private weak var lblDescription: UILabel!
    @IBOutlet private weak var imgPreview: UIImageView!
    @IBOutlet private weak var videoContainer: WKWebView!
    
    // Video
    lazy var mmPlayerLayer: MMPlayerLayer = {
        let l = MMPlayerLayer()
        l.cacheType = .memory(count: 5)
        l.coverFitType = .fitToPlayerView
        l.videoGravity = AVLayerVideoGravity.resizeAspect
        l.replace(cover: CoverA.instantiateFromNib())
        l.repeatWhenEnd = true
        return l
    }()
    
    // MARK: Lyfcycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: Instance Methods
    func renderInfo(info: [String:Any]) {
        
        let cellType = PostCellType(rawValue: info["cellType"] as! Int)
        
        if cellType == PostCellType.Video {
            
            if let videoURL = info["url"] as? String, let url = URL(string: videoURL)  {
                
                videoContainer.isHidden = true
                mmPlayerLayer.playView = videoContainer
                mmPlayerLayer.set(url: url)
                mmPlayerLayer.resume()
                videoContainer.isHidden = false
                
            }
            
        }
        else {
            
            if let imageURL = info["url"] as? String {
                
                imgPreview.setImageURLWithPlaceholder(sourceURL: imageURL, placeholderName: "placeholder")
                videoContainer.isHidden = true
                imgPreview.isHidden = false
            }
            
        }
        
        if let description = info["description"] as? String {
            lblDescription.text = description
        }
        
    }
    
}
