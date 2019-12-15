//
//  APIWorker.swift
//  Memeful
//
//  Created by LKB-L-105 on 13/12/19.
//

import UIKit

class APIWorker {

    // Load Posts from API
    static func loadDashboard(request: Home.Request, callback: @escaping (APICallback)) {
                        
        let url = String(format: request.filterOption.getURL(), request.page)
        _ = APIManager.shared.sendHTTPRequest(url: url, httpMethod: .get, params: nil, callback:callback)
        
    }
    
    // Load Comments from API
    static func loadComments(postID: String, callback: @escaping (APICallback)) {
                        
        let url = String(format: BEST_COMMENTS_API, postID)
        _ = APIManager.shared.sendHTTPRequest(url: url, httpMethod: .get, params: nil, callback:callback)
        
    }
    
    
}
