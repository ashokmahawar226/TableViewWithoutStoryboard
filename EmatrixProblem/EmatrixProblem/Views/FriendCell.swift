//
//  FriendCell.swift
//  EmatrixProblem
//
//  Created by ashok Mahawar on 25/11/19.
//  Copyright © 2019 ashok Mahawar. All rights reserved.
//

import Foundation
import UIKit

class FriendCell: UITableViewCell {
    
    var myLabel1: UILabel!
    var myLabel2: UILabel!
    var profileImage : UIImageView!
    var fullNameLbl: UILabel!
    var emailID: UILabel!


    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //
        profileImage = UIImageView.init()
        profileImage.clipsToBounds = true
        profileImage.backgroundColor = .lightGray
        profileImage.layer.cornerRadius = 50
        contentView.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        profileImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        profileImage.widthAnchor.constraint(equalTo: profileImage.heightAnchor, multiplier: 1.0/1.0).isActive = true
        
        //
        fullNameLbl = UILabel()
        fullNameLbl.textColor = UIColor.black
        contentView.addSubview(fullNameLbl)
        fullNameLbl.translatesAutoresizingMaskIntoConstraints = false
        fullNameLbl.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10).isActive = true
        fullNameLbl.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 10).isActive = true
        fullNameLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        fullNameLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //
        emailID = UILabel()
        emailID.textColor = UIColor.black
        contentView.addSubview(emailID)
        emailID.translatesAutoresizingMaskIntoConstraints = false
        emailID.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10).isActive = true
        emailID.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 10).isActive = true
        emailID.topAnchor.constraint(equalTo: fullNameLbl.bottomAnchor, constant: 0).isActive = true
        emailID.heightAnchor.constraint(equalToConstant: 30).isActive = true

    }

}
