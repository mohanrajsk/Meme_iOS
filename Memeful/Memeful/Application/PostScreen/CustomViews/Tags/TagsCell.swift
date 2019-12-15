//
//  TagsCell.swift
//  Memeful
//
//  Created by LKB-L-105 on 14/12/19.
//

import UIKit

class TagsCell: UITableViewCell {

    // MARK: UIElements
    @IBOutlet var vwTags: AMTagListView!
    @IBOutlet var lblViews: UILabel!
    @IBOutlet weak var tagsHeight: NSLayoutConstraint!
    
    // MARK: LyfCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vwTags.scrollDirection = .horizontal
        AMTagView.appearance().tintColor = UIColor.green
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func renderInfo(info: [String : Any]){
        
        if let views = info["views"] as? Int{
            lblViews.text = "\(UtilsManager.addCommaForNumber(largeNumber: "\(views)")) views"
        }
        
        if let tags = info["tags"] as? [String] {
            
            vwTags.addTags(tags)
            tagsHeight.constant = (tags.count == 0) ? 0.0 : 50.0;

        }
       
        
    }
    
}
