//
//  AuthAPI.swift
//  NaviMatchin
//
//  Created by Kento Katsumata on 2019/02/26.
//  Copyright © 2019 hiropon. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SwiftyJSON

class AuthAPI{
    
    //TODO: 画像の保存
    public func createAccount(firstName:String,lastName:String,email:String,password:String,completionHandler:@escaping (Any?)->Void){
        let ref = Database.database().reference()

        let path = ref.child("user").queryOrdered(byChild:"username").queryEqual(toValue : firstName)
        path.observe(.value, with:{ (snapshot: DataSnapshot) in
            if snapshot.value is NSNull{
                Auth.auth().createUser(withEmail: email, password: password){user, error in
                    if error == nil && user != nil{
                        let userID = Auth.auth().currentUser!.uid
                        UserDefaults.standard.set(userID, forKey: "UID")
                        ref.child("user/\(userID)").updateChildValues(["firstName":firstName,"lastName":lastName,"email":email])
                        //UserDefaults.standard.set(username, forKey: "USERNAME")
                        completionHandler(200)
                    }else{
                        completionHandler(404)
                    }
                }
            }else{
                completionHandler(409)
            }
        })
    }
}
