//
//  PostOptionsView.swift
//  Memeful
//
//  Created by LKB-L-105 on 14/12/19.
//

import UIKit

class PostOptionsView: UIView {

    // MARK: UIElements
    @IBOutlet var vwContainer: UIView!
    @IBOutlet weak var upVote: UIButton!
    @IBOutlet weak var downVote: UIButton!
    @IBOutlet weak var fav: UIButton!
    @IBOutlet weak var share: UIButton!

   
    // MARK: Lyfcycle
    required init?(coder aDecoder: NSCoder) {
       
       super.init(coder: aDecoder)
       buildUI()
       
    }

    required override init(frame: CGRect) {
       
       super.init(frame: frame)
       buildUI()
       
    }
    
    override func awakeFromNib() {
        // vwContainer.setAsCardView()
    }
    
    // MARK: Instance Methods
    private func buildUI(){
    
        let views = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        let contentView = views?[0] as! UIView
        contentView.frame = self.bounds
        self.addSubview(contentView)

    }
    
    func renderInfo(up: Int, down: Int, favour: Int){
        
        setTitle(title: "\(up)", forButton: upVote)
        setTitle(title: "\(down)", forButton: downVote)
        setTitle(title: "\(favour)", forButton: fav)
        
    }
    
    func setTitle(title: String, forButton button: UIButton) {
        
        button.setTitle(title, for: .normal)
        button.setTitle(title, for: .selected)
        
    }

}
