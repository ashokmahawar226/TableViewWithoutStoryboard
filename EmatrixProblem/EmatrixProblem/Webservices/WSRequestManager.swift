//
//  WSRequestManager.swift
//  EmatrixProblem
//
//  Created by ashok Mahawar on 24/11/19.
//  Copyright © 2019 ashok Mahawar. All rights reserved.
//

import Foundation

class WSRequestManager: NSObject {
    var endPoint : String = ""
    
    init(_ endPoint : String) {
        self.endPoint = endPoint
    }
    
    func prePareRequest() -> URLRequest? {
        return nil
    }
    
    func getParameter() -> String {
        return ""
    }
}
