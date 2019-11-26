//
//  FriendsManager.swift
//  EmatrixProblem
//
//  Created by ashok Mahawar on 25/11/19.
//  Copyright © 2019 ashok Mahawar. All rights reserved.
//

import Foundation
import RxSwift

final class FriendsManager: NSObject {
    static let shared = FriendsManager.init()
    var userInfo = [String : FriendInformation]()
    
    let taskDownloadImage = PublishSubject<String>()
    let taskError = PublishSubject<NSError>()


    private override init() {
        //
    }
    
    
    func getFriendList(_ emailId : String) {
       WebAPIManager.perFormRequest(WSGetFriendList.init(emailId)) { (res, error, errorCode) in
            if error == nil {
                if let result : NSDictionary = res as? NSDictionary {
                    if let users : NSArray = result["items"] as? NSArray {
                        for user in users {
                            if let data : NSDictionary = user as? NSDictionary {
                                if let fname = data["firstName"] as? String, let lname = data["lastName"] as? String,let email = data["emailId"] as? String,let imageurl = data["imageUrl"] as? String{
                                    FriendsManager.shared.userInfo[imageurl] = FriendInformation.init(email, fname, lname, imageurl)
                                    self.getImage(imageurl)
                                }
                            }
                        }
                    }
                }
            } else {
                self.taskError.onNext(error! as NSError)
        }
        }
    }
    
    func getImage(_ url : String){
        print("getImage : \(url)")
             let coverImage : WSDownloadImage = WSDownloadImage.init(url)
             WebAPIManager.perFormRequest(coverImage) { (response, error, errorCode) in
                 if let resDict : NSDictionary = response as? NSDictionary {
                     if let data : NSData = resDict["data"] as? NSData, let url : URL = resDict["url"] as? URL {
                         let user : FriendInformation = FriendsManager.shared.userInfo[url.absoluteString]!
                         user.updateImage(data)
                         FriendsManager.shared.userInfo[url.absoluteString] = user
                        DataBase.shared.insertUserInfomation(user)
                        self.taskDownloadImage.onNext(url.absoluteString)
                     }
                 }
             }
     }
    
    func logoutFromAPP()  {
        DataBase.shared.deleteInformation()
        LocalStorage.shared.removeFromLocalStorage(AppConstant.EMAILID)
        userInfo.removeAll()
    }
}
