//
//  UIView+Design.swift
//  SwiftCodeBase
//
//  Created by Jegan on 5/19/17.
//  Copyright © 2017 CodeBase. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
      
   
    
    func closeKeyboard(){
        self.endEditing(true)
    }
    
    func setAsRoundedCorner(cornerRadius:CGFloat, borderWidth: CGFloat, borderColor:UIColor){
        
        //Corner Radius
        self.layer.cornerRadius = cornerRadius;
        self.clipsToBounds = true;
        
        //Add borders
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = borderColor.cgColor;
    }
    
    // App specific
    func setAsSmoothCorner(corner: CGFloat = 5.0){
        
        self.setAsRoundedCorner(cornerRadius: corner, borderWidth: 0.0, borderColor: UIColor.clear)
        
    }
    
    func setAsCardView(){

        self.layer.cornerRadius = 5
        let shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 5)
        layer.cornerRadius = 5.0
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -10);
        layer.shadowOpacity = 0.2
        layer.shadowPath = shadowPath.cgPath
        
    }
    
    func setAsCardView(opacity:Float){
        
        self.layer.cornerRadius = 2
        let shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 2)
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1);
        layer.shadowOpacity = opacity
        layer.shadowPath = shadowPath.cgPath
        
    }
 
    func fixInView(_ baseView: UIView!) -> Void{
        
         baseView.frame = self.bounds
         baseView.addSubview(self)
         self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }
    
}
