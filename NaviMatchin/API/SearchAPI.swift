//
//  SearchAPI.swift
//  NaviMatchin
//
//  Created by Kento Katsumata on 2019/02/26.
//  Copyright © 2019 hiropon. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import SwiftyJSON

class SearchAPI{
    
    //get user info (閲覧ちゅうい)
    public func search(placeName:String,completionHandler:@escaping (Any?)->Void){
        var match = [[String]]()
        let ref = Database.database().reference()
        let path = ref.child("place").queryOrdered(byChild:"placeName").queryEqual(toValue: placeName)
        
        path.observe(.value, with:{ (snapshot: DataSnapshot) in
            var placeId:String?
            if snapshot.value is NSNull{
                completionHandler(nil)
            }else{
                let response = JSON(snapshot.value!)
                for  (key, _) in response {
                    placeId = key
                }
            }
            
            let moudameNemui = ref.child("naviSkill").queryOrdered(byChild:"placeID").queryEqual(toValue: placeId)
            moudameNemui.observe(.value, with:{ (snapshot: DataSnapshot) in
                if snapshot.value is NSNull{
                    completionHandler(nil)
                }else{
                    let response = JSON(snapshot.value!)
                    //print(response)
                    for  (key, _) in response {
                        placeId = key
                        
                        let PiroYaKentyPon1 = ref.child("user/\(response[placeId!]["accountID"])")
                        //description
                        let description = response[placeId!]["description"].string

                        
                        //accountId
                        PiroYaKentyPon1.observe(.value, with:{ (snapshot: DataSnapshot) in
                            if snapshot.value is NSNull{
                                completionHandler(nil)
                            }else{
                                let response = JSON(snapshot.value!)
                                print(response["firstName"])
                                print(response["lastName"])
                                print(description!)
                                match.append(["\(response["firstName"])","\(response["lastName"])",description!])
                                print(match)
                                completionHandler(match)
                            }
                        })
                    }
                }
            })
        }
        )
        
    }
    
    
    
}

