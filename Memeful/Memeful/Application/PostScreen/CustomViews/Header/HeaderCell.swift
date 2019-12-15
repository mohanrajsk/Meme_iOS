//
//  HeaderCell.swift
//  Memeful
//
//  Created by LKB-L-105 on 14/12/19.
//

import UIKit

class HeaderCell: UITableViewCell {

    // MARK: UIElements
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblFollow: UILabel!
    @IBOutlet private weak var lblLetter: UILabel!
    @IBOutlet private weak var lblName: UILabel!
    @IBOutlet private weak var lblTimeStamp: UILabel!
    @IBOutlet private weak var imgProfile: UIImageView!
    @IBOutlet private weak var btnMore: UIButton!
    
    
    // MARK: LyfCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgProfile.setAsSmoothCorner(corner: (self.imgProfile.frame.size.height / 2))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
 
    
    // MARK: Instance Methods
    // Render Cell Info
    func renderHeaderInfo(info: [String:Any]) {
        
        if let title = info["title"] as? String {
            lblTitle.text = title
        }
        
        if let timeStamp = info["timeStamp"] as? Double {
            lblTimeStamp.text = UtilsManager.timeAgoSinceDate(timeInSeconds: timeStamp)
        }
        
        if let postBy = info["postBy"] as? String {
            lblName.text = postBy
            lblLetter.text = postBy.first?.uppercased()
            lblLetter.isHidden = false
        }
        else{
            lblLetter.isHidden = true
        }
                
    }
    
}
