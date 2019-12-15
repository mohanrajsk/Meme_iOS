//
//  FilterView.swift
//  Memeful
//
//  Created by LKB-L-105 on 14/12/19.
//

import UIKit

protocol FilterViewDelegate: class {
    func receiveFilterEvent(index: Int)
}

class FilterView: UIView {

    // MARK: Variables
    var buttons:[UIButton] = []
    var delegate: FilterViewDelegate?
    
    // MARK: UIElements
    @IBOutlet var vwContainer: UIView!
    @IBOutlet weak var mPopular: UIButton!
    @IBOutlet weak var mRandom: UIButton!
    @IBOutlet weak var mNewest: UIButton!
    @IBOutlet weak var uPopular: UIButton!
    @IBOutlet weak var uRising: UIButton!
    @IBOutlet weak var uNewest: UIButton!
    
    // MARK: Lyfcycle
    required init?(coder aDecoder: NSCoder) {
       
       super.init(coder: aDecoder)
       buildUI()
       
    }

    required override init(frame: CGRect) {
       
       super.init(frame: frame)
       buildUI()
       
    }
       
     // MARK: Instance Methods
     private func buildUI(){
        
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        vwContainer.fixInView(self)
        UtilsManager.setRoundedCorner(forViews: [vwContainer])
        buttons = [self.mPopular, self.mRandom, self.mNewest, self.uPopular, self.uRising, self.uNewest]
        
     }

    private func reset() {
        
        for button in buttons {
            button.isSelected = false
        }
        
    }
    func chooseByIndex(index: Int){
        
        reset()
        let button = buttons[index]
        button.isSelected = true
        self.delegate?.receiveFilterEvent(index: index)
        
    }
    
}
extension FilterView {
    
    // MARK: UI Actions
    @IBAction func chooseCategory(_ sender: Any) {
        
        let button = sender as! UIButton
        chooseByIndex(index: button.tag)
        self.removeFromSuperview()
        
    }
    
}
