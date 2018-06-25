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
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class Utilities: NSObject {
    
    //Colors
    let darkBlueColor = #colorLiteral(red: 0.1333333333, green: 0.1921568627, blue: 0.2470588235, alpha: 1)
    let lightBlueColor = #colorLiteral(red: 0.4039215686, green: 0.5019607843, blue: 0.6235294118, alpha: 1)
    let whiteColor = #colorLiteral(red: 0.9411764706, green: 0.9137254902, blue: 0.8784313725, alpha: 1)
    let redColor = #colorLiteral(red: 0.5882352941, green: 0.1568627451, blue: 0.1058823529, alpha: 1)
    let grayColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
    let greenColor = #colorLiteral(red: 0.137254902, green: 0.6352941176, blue: 0.3019607843, alpha: 1)
    
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

class FirebaseController {
    
    var UtilitiesRef = Utilities()
    
    // Main Reference to Firebase Database
    var mainDbRef : DatabaseReference {
        return Database.database().reference()
    }
    // Main reference to Firebase Storage
    var mainStRef : StorageReference {
        return Storage.storage().reference(forURL: "gs://classroom-19991.appspot.com/")
    }
    
    // Login with a Email, Password and a CompletionHandler
    public func Login (email : String, password : String, completion : @escaping () -> Void)  {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            //Check if the User Exist
            if user != nil {
                // Login Successfully
                completion()
                
            } else {
                if let myError = error?.localizedDescription {
                    print(myError)
                } else {
                    print("Error in Auth Section")
                }
            }
        })
    }
    
    // Register a user in Firebase Auth and save the data in the database
    public func Signin (name: String, email : String, password: String, profileImg : UIImage, completion : @escaping () -> Void) {
        Auth.auth().createUser(withEmail: email, password: password , completion: { (user, error) in
            //Check if the user exist
            if user != nil {
                //User created Sucessfully
                print("User Created Sucessfully")
                //Reference to Profile
                let profileRef = self.mainDbRef.child("Users").child((user?.uid)!).child("Profile")
                //Add Name and Email here, then the profileImage is uploaded
                profileRef.child("Name").setValue("\(name)")
                profileRef.child("Email").setValue("\(email)")
                // Reference to random image url Storage
                let imgStRef = self.mainStRef.child("Users_Profile_Image").child("\(self.UtilitiesRef.randomAlphaNumericString(length: 10)).jpg")
                //We create a PNG Representation of the image to upload
                if let UploadData = UIImageJPEGRepresentation(profileImg, 0.1) {
                    //Upload the image to the storage
                    imgStRef.putData(UploadData, metadata: nil, completion: { (Metadata, error) in
                        // Check for any error
                        if error != nil {
                            print(error!)
                        } else {
                            //Image Uploaded
                            //Get the download url of the image uploaded
                            if let ImageUploadedUrl = Metadata?.downloadURL()?.absoluteString {
                                //once the image is uploaded we upload the data again but with the imageUrl
                                profileRef.child("Name").setValue("\(name)")
                                profileRef.child("Email").setValue("\(email)")
                                profileRef.child("ProfileImageUrl").setValue("\(ImageUploadedUrl)")
                            }
                        }
                    })
                }
                completion()
            } else {
                if let myError = error?.localizedDescription {
                    print(myError)
                } else {
                    print("Error")
                }
            }
        })
    }
    
    
    
}
