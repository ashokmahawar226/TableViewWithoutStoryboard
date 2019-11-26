//
//  UserDefaults.swift
//  EmatrixProblem
//
//  Created by ashok Mahawar on 26/11/19.
//  Copyright © 2019 ashok Mahawar. All rights reserved.
//

import Foundation

final class LocalStorage: NSObject {
    static let shared = LocalStorage.init()
    private let localStorage = UserDefaults.standard
    
    private override init() {
        //
    }
    
    func saveToLocalStorage(_ key : String , _ value : String) {
        localStorage.set(value, forKey: key)
        localStorage.synchronize()
    }
    
    func getValueFromLocalStorage(_ key : String) -> String {
        return localStorage.string(forKey: key) ?? ""
    }
    
    func removeFromLocalStorage(_ key : String){
        localStorage.removeObject(forKey: key)
        localStorage.synchronize()
    }
}
