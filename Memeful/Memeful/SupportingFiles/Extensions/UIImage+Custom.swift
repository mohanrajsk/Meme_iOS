//
//  UIImage+Custom.swift
//  SwiftTutorial
//
//  Created by Lakeba_Prabhu on 05/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//
import UIKit
import AVFoundation

var defaultPlaceHolder:String = "logo"
public typealias CallBack = ((_ image: Image?, _ error: NSError?) -> ())

extension UIImageView {
    
    func setImageURLWithPlaceholder( sourceURL : String, placeholderName : String){
        
        self.kf.setImage(with: URL(string: sourceURL), placeholder: UIImage(named: placeholderName), options: [], progressBlock: nil, completionHandler: {[unowned self] (image, error, cacheType, url) in
            if error == nil {
                self.image = image
            }
            
        })
        
    }
    
}
