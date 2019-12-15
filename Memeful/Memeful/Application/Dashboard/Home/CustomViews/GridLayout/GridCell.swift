//
//  GridCell.swift
//  Memeful
//
//  Created by LKB-L-105 on 13/12/19.
//

import UIKit
import AVFoundation

class GridCell: UICollectionViewCell {
    
    // MARK: UIElements
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imgPreview: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblUpVotes: UILabel!
    @IBOutlet private weak var lblImageCount: UILabel!
    @IBOutlet private weak var imgVideo: UIImageView!
    
    // MARK: Variables
    var cellSource: Home.Model.Feed!
    
    // MARK: LyfCycle
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        UtilsManager.setRoundedCorner(forViews: [containerView, lblImageCount])
        
    }
    
    // MARK: Instance Methods & Computed Properties
    var feed: Home.Model.Feed? {
      
        didSet {
            if let feed = feed {
                
                cellSource = feed
                
                // Title
                if let title = feed.title{
                    lblTitle.text = title
                }
                
                // Up Votes
                if let upVotes = feed.upVotes{
                    lblUpVotes.text = "\(upVotes)"
                }
                
                // Image / Video
                imgPreview.image = nil

                if let items = feed.medias {
                    
                    for item in items {
                    
                        // Vide
                        if let videoURL = item.videoUrl {
                            
                            imgVideo.isHidden = false
                            AVAsset(url: URL.init(string: videoURL)!).generateThumbnail { [weak self] (image) in
                            
                                DispatchQueue.main.async {
                                    guard let image = image else { return }
                                    self?.imgPreview.image = image
                                }
                                
                            }
                            
                        }
                        // Image
                        else if let imageURL = item.url {
                            imgPreview.setImageURLWithPlaceholder(sourceURL: imageURL, placeholderName: "placeholder")
                            imgVideo.isHidden = true
                        }
                        
                    }
                    
                    // Image Count
                    if items.count > 1 {
                        lblImageCount.text = "\(items.count)"
                        lblImageCount.isHidden = false
                        imgVideo.isHidden = true
                    }
                    else{
                        lblImageCount.isHidden = true
                    }
                
                }
                
            }
      }
        
    }
    
    public func getHeight() -> CGFloat {
        return imgPreview.image?.size.height ?? 0
    }
    
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size.width = CGFloat(ceilf(Float(size.width)))
        layoutAttributes.frame = newFrame
        
        return layoutAttributes
        
    }
    
}

extension AVAsset {
    
    // Generate Thumbnail from Video url
    func generateThumbnail(completion: @escaping (UIImage?) -> Void) {
        
        DispatchQueue.global().async {
        
            let imageGenerator = AVAssetImageGenerator(asset: self)
            let time = CMTime(seconds: 0.0, preferredTimescale: 600)
            let times = [NSValue(time: time)]
            
            imageGenerator.generateCGImagesAsynchronously(forTimes: times, completionHandler: { _, image, _, _, _ in
            
                if let image = image {
                    completion(UIImage(cgImage: image))
                } else {
                    completion(nil)
                }
                
            })
            
        }
    }
}
