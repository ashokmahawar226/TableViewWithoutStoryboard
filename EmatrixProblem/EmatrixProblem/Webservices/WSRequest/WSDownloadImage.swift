//
//  WSDownloadImage.swift
//  EmatrixProblem
//
//  Created by ashok Mahawar on 24/11/19.
//  Copyright © 2019 ashok Mahawar. All rights reserved.
//

import Foundation
class WSDownloadImage : WSRequestManager {
    
    override init(_ endPoint: String) {
        super.init(endPoint)
    }
    
    override func prePareRequest() -> URLRequest? {
        let url = URL.init(string: endPoint)
        var urlRequest : URLRequest = URLRequest.init(url: url!)
        urlRequest.httpMethod = "GET"
        return urlRequest
    }
    
    override func getParameter() -> String {
        return ""
    }
}
