//
//  Message.swift
//  Digital Class
//
//  Created by Celina Martinez on 16/6/18.
//  Copyright © 2018 Jadapema. All rights reserved.
//

import UIKit
import FirebaseAuth

class Message: NSObject {
    var toId : String?
    var fromId : String?
    var text : String?
    var timestamp : Int?
    var id : String?
    
    func chatPartnerId () -> String? {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
    
}
