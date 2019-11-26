//
//  WSGetFriendList.swift
//  EmatrixProblem
//
//  Created by ashok Mahawar on 24/11/19.
//  Copyright © 2019 ashok Mahawar. All rights reserved.
//

import Foundation

class WSGetFriendList: WSRequestManager {
    
    var emailId = ""

    override init(_ emailId : String ) {
        super.init("/list")
        self.emailId = emailId
    }
    
    override func prePareRequest() -> URLRequest? {
        let strUrl = AppConstant.baseUrl + endPoint
        let url : URL = URL.init(string: strUrl)!
        var urlRequest : URLRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = "POST"
        let json = getParameter()
        urlRequest.httpBody = json.data(using: .utf8)
        return urlRequest
    }
    
    override func getParameter() -> String {
        var bodyParameter = [String : String]()
        bodyParameter["emailId"] = emailId
        return WebAPIManager.jsonToString(json: bodyParameter)
       // return ""
    }
}
