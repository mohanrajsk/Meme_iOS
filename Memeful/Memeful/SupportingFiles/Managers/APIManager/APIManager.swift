//
//  APIManager.swift
//  Assesment
//
//  Created by Jegan on 07/01/17.
//  Copyright © 2017 BitsOHacker. All rights reserved.
//

import UIKit

let NO_INTERNET_ERROR: Error? = NSError(domain:"", code:666, userInfo:nil)

// typealias APICallback = (Data?, Int, Error?) -> Void
typealias APICallback = (Data?, String?) -> Void

enum HTTPMethod {
    case get
    case post
}

class APIManager: NSObject {
    
    let BaseURL = "https://api.imgur.com/"
    
    static let shared = APIManager()

    // Avoid basic init using () instead of sharedManager
    private override init() {
        super.init()
    }
    
    func sendHTTPRequest(url: String, httpMethod: HTTPMethod, params: [String : Any]?, headers: [String : Any]? = nil, callback: @escaping(APICallback)){
        
        // Check for internet Connection
        guard UtilsManager.isNetworkReached else { callback(nil, "Please check your internet and try again!"); return }
        
        // Build Request
        var apiURL = url
        if (!url.contains("http://") && !url.contains("https://")) {
            apiURL = BaseURL + url
        }
        
        var request = URLRequest(url: URL(string: (apiURL))!)

        // Append Payload
        if httpMethod == .post {
            request.httpMethod = "POST"
            let payload = try? JSONSerialization.data(withJSONObject: params ?? [:], options: .prettyPrinted)
            request.httpBody = payload
            print("---- Request URL: \(apiURL)")
            print("---- Request Params: \(String(describing: payload))")
        }
        
        // Build Data Task
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            var statusCode: Int!
            if let response = response as? HTTPURLResponse {
                
                statusCode = response.statusCode
                print("---- Status Code: \(String(describing: statusCode))")
                
            }
            
            // Response Success
            if statusCode == 200 {
                
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("---- Response: \(dataString)")
                }
                callback(data, nil)
                
            }
            // Response Failed
            else if error != nil {
                
                callback(nil, error?.localizedDescription)
                
            }

            // Parse Error from Response
            else if let errorResponse = data {
                
                if let result = try? JSONSerialization.jsonObject(with: errorResponse, options: []) as? [String:Any] {
                    
                    if let errorInfo = result["data"] as? [String:Any], let message = errorInfo["error"] as? String {
                        callback(nil, message)
                    }
                    
                }
                                
            }
            else {
                callback(nil, "Oops something wentr wrong. Please try later")
            }
            
        }
        task.resume()

    }
    
    
}
