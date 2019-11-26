//
//  WebAPIManager.swift
//  EmatrixProblem
//
//  Created by ashok Mahawar on 24/11/19.
//  Copyright © 2019 ashok Mahawar. All rights reserved.
//

import Foundation
import Alamofire

class WebAPIManager: NSObject {
    
    class func perFormRequest(_ request : WSRequestManager, completion : @escaping (_ _reponse : Any? , _ error : Error? , _ errorCode : Int) -> Void ){
        var urlRequest : URLRequest = request.prePareRequest()!
        urlRequest.timeoutInterval = 60
        
        Alamofire.request(urlRequest).responseJSON { (response) in
            
            guard let _ = response.data , response.error == nil else {
                completion(["data" : response.data,"url":response.request?.url],response.error,0)
                return
            }
            
            if let res : HTTPURLResponse = response.response {
                if res.statusCode == 200 {
                    if let value : NSArray = response.value as? NSArray {
                        completion(value,nil,0)
                        return
                    } else if let value : NSDictionary = response.value as? NSDictionary {
                        completion(value,nil,0)
                    }  else {
                    completion(["data" : response.data!,"url":response.request?.url],nil,0)
                        return
                    }
                } else {
                    var errorMessgae = ""
                    if let result = response.result.value {
                        if let resultDict : NSDictionary = result as? NSDictionary {
                            if let errors : [Any] = resultDict["errors"] as? [Any] {
                                for error in errors {
                                    if let messageDict : [String : Any] =  error as? [String : Any] {
                                        if let message : String = messageDict["message"] as? String {
                                            if !errorMessgae.isEmpty {
                                                errorMessgae = errorMessgae + ","
                                            }
                                            
                                            errorMessgae = errorMessgae + message
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    if errorMessgae.isEmpty {
                        
                    }
                    
                    if errorMessgae.isEmpty {
                        errorMessgae = response.error?.localizedDescription ?? "Response Error"
                    }
                    
                    completion(nil,NSError(domain: "\(res.statusCode)", code: res.statusCode, userInfo: ["message" : errorMessgae]),res.statusCode)
                    return
                }
            }
        }
        
        
        
    }
    
    class func jsonToString(json: Any) -> String{
        do {
            let data =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            let convertedString = String(data: data, encoding: String.Encoding.utf8) 
            return convertedString ?? ""
        } catch let myJSONError {
            print(myJSONError)
        }
        return ""
    }
}
