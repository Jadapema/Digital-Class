//
//  User.swift
//  Digital Class
//
//  Created by Celina Martinez on 16/6/18.
//  Copyright © 2018 Jadapema. All rights reserved.
//

import UIKit

class User: NSObject, NSCoding {
    var Name : String!
    var Email : String!
    var ProfileImageUrl : String!
    var ProfileImage = #imageLiteral(resourceName: "student")
    var UserId : String!
    var isSelected : Bool!
    
    override init() {}
    
    required init(N:String,E:String,PIU:String,PI:UIImage,UID:String,IS:Bool) {
        Name = N
        Email = E
        ProfileImageUrl = PIU
        ProfileImage = PI
        UserId = UID
        isSelected = IS
    }
    required init(coder aDecoder: NSCoder) {
        Name = aDecoder.decodeObject(forKey: "Name") as? String
        Email = aDecoder.decodeObject(forKey: "Email") as? String
        ProfileImageUrl = aDecoder.decodeObject(forKey: "ProfileImageUrl") as? String
        ProfileImage = (aDecoder.decodeObject(forKey: "ProfileImage") as? UIImage)!
        UserId = aDecoder.decodeObject(forKey: "UserId") as? String
        isSelected = aDecoder.decodeObject(forKey: "isSelected") as? Bool
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(Name, forKey: "Name")
        aCoder.encode(Email, forKey: "Email")
        aCoder.encode(ProfileImageUrl, forKey: "ProfileImageUrl")
        aCoder.encode(ProfileImage, forKey: "ProfileImage")
        aCoder.encode(UserId, forKey: "UserId")
        aCoder.encode(isSelected, forKey: "isSelected")
    }
}
