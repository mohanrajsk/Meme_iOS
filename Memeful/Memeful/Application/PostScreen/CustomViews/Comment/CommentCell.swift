//
//  CommentCell.swift
//  Memeful
//
//  Created by LKB-L-105 on 14/12/19.
//

import UIKit

class CommentCell: UITableViewCell {

    // MARK: UIElements
    @IBOutlet private weak var imgProfile: UIImageView!
    @IBOutlet private weak var lblLetter: UILabel!
    @IBOutlet private weak var lblAuthor: UILabel!
    @IBOutlet private weak var lblTimeStamp: UILabel!
    @IBOutlet private weak var lblComment: UILabel!
    @IBOutlet private weak var lblUps: UILabel!
    @IBOutlet private weak var lblDowns: UILabel!
    @IBOutlet private weak var lblReply: UILabel!
    
    // MARK: Lyf cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblReply.setAsSmoothCorner(corner: 15)
        imgProfile.setAsSmoothCorner(corner: (self.imgProfile.frame.size.height / 2))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: Instance Methods
    func renderInfo(info: [String:Any]) {
        
        if let author = info["author"] as? String {
           lblAuthor.text = author
           lblLetter.text = author.first?.uppercased()
           lblLetter.isHidden = false
        }
        else{
            lblLetter.isHidden = true
        }
        
        if let comment = info["comment"] as? String {
           lblComment.text = comment
        }
        
        if let timeStamp = info["timeStamp"] as? Double {
            lblTimeStamp.text = UtilsManager.timeAgoSinceDate(timeInSeconds: timeStamp)
        }

        if let ups = info["ups"] as? Int {
            lblUps.text = "\(ups)"
        }
        
        if let downs = info["downs"] as? Int {
           lblDowns.text = "\(downs)"
        }
        
        if let count = info["repliesCount"] as? Int {
          lblReply.text = "\(count) Replies"
          lblReply.isHidden = (count == 0)
        }
        
    }
    
}
