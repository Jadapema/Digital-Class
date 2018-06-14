//
//  Utilities.swift
//  Digital Class
//
//  Created by Celina Martinez on 7/6/18.
//  Copyright © 2018 Jadapema. All rights reserved.
//

//  Colors
//  Dark Blue #22313F  (r:34,g:49,b:63)
//  Light Blue #67809F  (r:103,g:128,b:159)
//  White #F0E9E0  (r:240,g:233,b:224)
//  Red #96281B  (r:150,g:40,b:27)
//  Gray #979797  (r:151,g:151,b:151)


import UIKit

class Utilities: NSObject {
    
    //Colors
    let darkBlueColor = #colorLiteral(red: 0.1333333333, green: 0.1921568627, blue: 0.2470588235, alpha: 1)
    let lightBlueColor = #colorLiteral(red: 0.4039215686, green: 0.5019607843, blue: 0.6235294118, alpha: 1)
    let whiteColor = #colorLiteral(red: 0.9411764706, green: 0.9137254902, blue: 0.8784313725, alpha: 1)
    let redColor = #colorLiteral(red: 0.5882352941, green: 0.1568627451, blue: 0.1058823529, alpha: 1)
    let grayColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
    
    //Return a random Alphanumeric Number With a length
    public func randomAlphaNumericString(length: Int) -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.characters.count)
        var randomString = ""
        for _ in 0..<length {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
            let newCharacter = allowedChars[randomIndex]
            randomString += String(newCharacter)
        }
        return randomString
    }
    
    public func littleDownMovement (view : UIView) {
        let time = 0.2
        UIView.animate(withDuration: time, animations: {
            view.center.y += 5
        }) { (finished) in
            UIView.animate(withDuration: time, animations: {
                view.center.y -= 5
            })
        }
    }
    
    
    // validate an email for the right format
    public func isValidEmail(email:String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    

}
