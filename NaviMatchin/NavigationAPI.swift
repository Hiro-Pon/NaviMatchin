//
//  NavigationAPI.swift
//  NaviMatchin
//
//  Created by Kento Katsumata on 2019/02/26.
//  Copyright © 2019 hiropon. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftyJSON

class NavigationAPI{
    
    public func addNavigation(placeName:String, description:String){
        let ref = Database.database().reference()
        print("called")
        checkAlternate(placeName: placeName) { (status) in
            var autoIdPlaceAll: String?
            if status as! String == "nil"{
                if let autoIdPlace = ref.childByAutoId().key{
                    autoIdPlaceAll = autoIdPlace
                    ref.child("place").child(autoIdPlace).updateChildValues(["placeName":placeName])
                }
                let accountId = UserDefaults.standard.value(forKey: "UID")
                if let autoIdSkill = ref.childByAutoId().key{
                    ref.child("naviSkill").child(autoIdSkill).updateChildValues(["accountID":accountId!,"description":description,"placeID":autoIdPlaceAll!])
                }
            }else{
                let accountId = UserDefaults.standard.value(forKey: "UID")
                let placeID = status as! String
                if let autoIdSkill = ref.childByAutoId().key{
                    ref.child("naviSkill").child(autoIdSkill).updateChildValues(["accountID":accountId!,"description":description,"placeID":placeID])
                }
            }
        }
    }
    
    private func checkAlternate(placeName:String,completionHandler:@escaping (Any?)->Void){
        let ref = Database.database().reference()
        let path = ref.child("place").queryOrdered(byChild:"placeName").queryEqual(toValue : placeName)
        path.observe(.value, with:{ (snapshot: DataSnapshot) in
            if snapshot.value is NSNull{
                completionHandler("nil")
            }else{
                let response = JSON(snapshot.value!)
                var placeId:String?
                for  (key, _) in response {
                    placeId = key
                }
                completionHandler(placeId)
            }
        })
    }
}
