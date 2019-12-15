//
//  UtilsManager.swift
//  EzidoxCollector
//
//  Copyright © 2019 Lakeba. All rights reserved.
//

import UIKit

class UtilsManager: NSObject {

    static let shared = UtilsManager()
    
    //Avoid basic init using () instead of sharedManager
    private override init() {
        super.init()
        UtilsManager.monitorNetwork()
    }
    
    static var appName: String {
        return Bundle.main.infoDictionary?["CFBundleName"] as! String
    }
    
    static func trim(_ message: String) -> String {
        return message.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    static func showAlertMessage(title: String = UtilsManager.appName, message: String, type: Theme = Theme.info){
        
        DispatchQueue.main.async {
            
            if trim(message).count > 0 {
                
                let validationAlert = MessageView.viewFromNib(layout: .messageView)
                validationAlert.configureTheme(type)
                validationAlert.button?.setTitleColor(.white, for: .normal)
                validationAlert.titleLabel?.textColor = UIColor.white
                validationAlert.iconImageView?.tintColor = UIColor.white
                validationAlert.bodyLabel?.textColor = UIColor.white
                validationAlert.backgroundColor = UIColor.appThemeDark
                validationAlert.configureDropShadow()
                
                var validationConfig = SwiftMessages.Config()
                validationConfig.duration = .automatic
                validationConfig.interactiveHide = true
                validationConfig.presentationStyle = .top
                validationConfig.presentationContext = .window(windowLevel: .statusBar)
                validationAlert.configureContent(title: title, body: message)
                
                validationAlert.button?.isHidden = true
                SwiftMessages.hideAll()
                SwiftMessages.show(config: validationConfig, view: validationAlert)
                
            }
            
        }
        
    }
    
    static func makeViewAsPopUp(viewToDisplay: UIView) -> KLCPopup {
           return KLCPopup(contentView: viewToDisplay, showType: .bounceInFromTop, dismissType: .bounceOutToTop, maskType: .dimmed, dismissOnBackgroundTouch: true, dismissOnContentTouch: false)
    }
    
}

// MARK: Network & Web services
extension UtilsManager {
    
    // MARK: - Network
    static var networkChangedBlock: ((Bool) -> Void)?
    static var permissionStatusBlock: ((Bool) -> Void)?
    static var reachability = Reachability()!
    
    static var isNetworkReached:Bool{
        get{
            if UtilsManager.reachability.currentReachabilityStatus == .notReachable{
                return false
            }
            else{
                return true
            }
        }
    }
 
    static func monitorNetwork() {
        
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                if(UtilsManager.networkChangedBlock != nil){
                    UtilsManager.networkChangedBlock!(true)
                }
            }
        }
        
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                if(UtilsManager.networkChangedBlock != nil){
                    UtilsManager.networkChangedBlock!(false)
                }
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
}

// MARK: UIElements & Design
extension UtilsManager {
    
    static func setRoundedCorner(forViews: [UIView]){

        for view in forViews {
            view.setAsSmoothCorner()
        }

    }
    
    static func getLoader(onView: UIView?) -> MBProgressHUD? {
        if let onView = onView {
            return UtilsManager.getLoader(onView: onView, withTitle: "")
        }
        return nil
    }
    
    static func getLoader(onView: UIView, withTitle: String) -> MBProgressHUD{
        let loader = MBProgressHUD.showAdded(to: onView, animated: true)
        loader.mode = MBProgressHUDMode.indeterminate
        loader.animationType = MBProgressHUDAnimation.zoomOut
        loader.label.text = withTitle
        return loader
    }
    
    static func hideLoader(_ loader: MBProgressHUD?){
        DispatchQueue.main.async {
            loader?.hide(animated: true)
        }
    }
    
    static func getProgressLoader(onView: UIView) -> MBProgressHUD{
        let loader = MBProgressHUD.showAdded(to: onView, animated: true)
        loader.mode = MBProgressHUDMode.annularDeterminate
        loader.animationType = MBProgressHUDAnimation.zoomOut
        return loader
    }

    static func getRootViewController() -> UIViewController {
        return UIApplication.shared.keyWindow?.rootViewController ?? UIViewController()
    }
    
    static func addCommaForNumber(largeNumber: String) -> String {
        
        let largeNumber = largeNumber
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let number = NSNumber(value: ( Double(largeNumber) ?? 0.0 ))
        return numberFormatter.string(from: number) ?? "0"
        
    }
     static func timeAgoSinceDate(timeInSeconds: Double) -> String {
            
           let date = NSDate(timeIntervalSince1970: timeInSeconds)
           let numericDates = true
           let calendar = NSCalendar.current
           let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
           let now = NSDate()
           let earliest = now.earlierDate(date as Date)
           let latest = (earliest == now as Date) ? date : now
           let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
           
           if (components.year! >= 2) {
               return "\(components.year!) years"
           } else if (components.year! >= 1){
               if (numericDates){
                   return "1 year"
               } else {
                   return "Last year"
               }
           } else if (components.month! >= 2) {
               return "\(components.month!) months"
           } else if (components.month! >= 1){
               if (numericDates){
                   return "1 month"
               } else {
                   return "Last month"
               }
           }
           else if (components.day! >= 2) {
               return "\(components.day!) days"
           } else if (components.day! >= 1){
               if (numericDates){
                   return "1 day"
               } else {
                   return "Yesterday"
               }
           } else if (components.hour! >= 2) {
               return "\(components.hour!) hr"
           } else if (components.hour! >= 1){
               if (numericDates){
                   return "1 hr"
               } else {
                   return "An hour ago"
               }
           } else if (components.minute! >= 2) {
               return "\(components.minute!) min"
           } else if (components.minute! >= 1){
               if (numericDates){
                   return "1 min"
               } else {
                   return "1 min"
               }
           } else if (components.second! >= 3) {
               return "\(components.second!) sec"
           } else {
               return "Just now"
           }
           
       }

}


// MARK: Input Validations
extension UtilsManager {

    // MARK: - Input validation
    static var validationFailedBlock: ((String, Any) -> Void)?

    static func sendValidationFailed(message : String) {
        UtilsManager.showAlertMessage(title: UtilsManager.appName, message: message, type: .warning)
    }


    static func validateEmail(email: String) -> Bool{
        
        let emailPattern:String = "^\\w+([\\.-]?\\w+)*@\\w+([\\.-]?\\w+)*(\\.\\w{1,})+$"
        do {
            let regularExpression = try NSRegularExpression(pattern: emailPattern)
            let nsEmail = email as NSString
            let results = regularExpression.matches(in: email,
                                                    options: [], range: NSMakeRange(0, nsEmail.length))
            let matches = results.map {nsEmail.substring(with: $0.range)}
            
            if(matches.count == 0){
                return false;
            }
            else if(email.range(of: "..") != nil){ //Check continous dots are present
                return false
            }
            else if(email.first == "."){ //Check email starts with .
                return false
            }
            else{
                //Check server part starts or ends with '-'
                let emailParts:Array = email.components(separatedBy: "@")
                let serverPart:String = emailParts[1]
                let namePart:String = emailParts[0]
                
                if(serverPart.range(of: "-.") != nil){
                    return false
                }
                else if(serverPart.first == "-"){
                    return false
                }
                else if(namePart.last == "."){
                    return false
                }
            }
            return true;
            
        } catch {
            return false
        }
    }
    
    static func validateInputField(fieldValue: String, fieldName: String, minLength: Int, maxLength: Int, isEmail:Bool) -> String? {
        
        if(fieldValue.trimmingCharacters(in: .whitespaces).count == 0){
            return "\(fieldName) cannot be empty"
        }
        else if(fieldValue.count < minLength){
            return "\(fieldName) should have minimum \(minLength) characters"
        }
        else if(fieldValue.count > maxLength){
            return "\(fieldName) cannot exceed \(maxLength) characters"
        }
        else if(isEmail && !UtilsManager.validateEmail(email: fieldValue)){
            return "Enter valid email address"
        }
        return nil
        
    }
    
}
