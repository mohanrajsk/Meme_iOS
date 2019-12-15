//
//  HeaderView.swift
//
//  Copyright © 2017 Lakeba. All rights reserved.
//

import UIKit

@objc protocol HeaderViewDelegate: class {
    
    @objc optional func didRightButtonClicked()
    @objc optional func didLeftButtonClicked()
    
}

class HeaderView: UIView {

    // Global Elements
    var presentVC: UIViewController?
    var navigationVC: UINavigationController?
    var delegate: HeaderViewDelegate?
    
    // Variables
    var isCustomLeftMenu: Bool! = false
    
    // MARK: UI Elements
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!

    @IBOutlet weak var lblTitle: UILabel!

    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var navigationView: UIView!
    
    // MARK: Lyf Cycle
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.setup()
        
    }   
    
    private func setup() {
        
        // Load View from bundle
        let views = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        let contentView = views?[0] as! UIView
        contentView.frame = self.bounds
        self.addSubview(contentView)
        
        // Set Over all height
        self.constraints.forEach { (constrain) in
            constrain.constant = UIApplication.shared.statusBarFrame.size.height + 44
        }
        
        // Set Status bar height
        self.statusBarView.constraints.forEach { (constrain) in
            constrain.constant = UIApplication.shared.statusBarFrame.size.height
        }
        
        // Pick Current Root View Controller
        if let nVC = UIApplication.shared.delegate?.window??.rootViewController as? UINavigationController {
            navigationVC = nVC
        }
        else {
            presentVC = UIApplication.shared.delegate?.window??.rootViewController
        }
        
        // Initialize UI
        buildUI()
        
    }
    
    // Initialize the UI
    private func buildUI() {
        
        btnRight.isHidden = true
        
    }
    
    // MARK: UIActions
    @IBAction func leftButtonClicked(_ sender: Any) {
    
        if !isCustomLeftMenu {
            
            if navigationVC != nil {
                navigationVC?.popViewController(animated: true)
            }
            else if presentVC != nil{
                presentVC?.dismiss(animated: true, completion: nil)
            }
            
            // sent delegate if they registered
            delegate?.didLeftButtonClicked!()
            
        }
        else {
            delegate?.didLeftButtonClicked!()
        }
        
    }
    
    @IBAction func rightButtonClicked(_ sender: Any) {
        
        if (delegate != nil) {
            delegate?.didRightButtonClicked!()
        }
        
    }
    
}

// MARK: UI Adjustments
extension HeaderView {
    
    func setTitle(_ title: String) {
        
        // There is any localized key matched then it will be replaced
        lblTitle.text = title
        lblTitle.isHidden = false
        
    }
        
    func setTextAlignment(direction: NSTextAlignment) {
        lblTitle.textAlignment = .left
    }
    
    // MARK: Buttons
    func setRightButtonTitle(_ title: String) {
    
        btnRight.setTitle(title, for: .normal)
        btnRight.setTitleColor(UIColor.white, for: .normal)
        btnRight.isHidden = false
    
    }
    
    func setLeftButtonTitle(_ title: String) {
        
        btnLeft.setTitle(title, for: .normal)
        btnLeft.setTitleColor(UIColor.white, for: .normal)
        btnLeft.isHidden = false
        
    }
    
    func hideAllButtons() {
        
        btnRight.isHidden = true
        btnLeft.isHidden = true
        lblTitle.textAlignment = .center
        
    }
    
    
}
