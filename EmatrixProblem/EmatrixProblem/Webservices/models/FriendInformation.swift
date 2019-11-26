//
//  FriendInformation.swift
//  EmatrixProblem
//
//  Created by ashok Mahawar on 25/11/19.
//  Copyright © 2019 ashok Mahawar. All rights reserved.
//

import Foundation
import UIKit
class FriendInformation: NSObject,NSCoding {
    
    var emailID : String = ""
    var firstName : String = ""
    var lastName : String = ""
    var imageUrl : String = ""
    var profileImage : NSData = NSData.init()
    
    init(_ emailID : String ,_ firstName : String, _ lastName : String, _ imageUrl : String) {
        self.emailID = emailID
        self.firstName = firstName
        self.lastName = lastName
        self.imageUrl = imageUrl
    }
    
    func updateImage(_ image : NSData) {
        profileImage = image
    }
    
    func encode(with coder: NSCoder) {
        //
    }
    
    required init?(coder: NSCoder) {
        //
    }
    
}
