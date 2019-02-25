//
//  AddNavigationInfoViewController.swift
//  NaviMatchin
//
//  Created by 中嶋裕也 on 2019/02/25.
//  Copyright © 2019 hiropon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class AddNavigationInfoViewController: UIViewController {
    
    lazy var db = Firestore.firestore()
    let loginId = UserDefaults.standard.value(forKey: "ToComform")
    
    @IBOutlet var placeTextFeld:UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeTextFeld.addBorderBottom(height: 0.3, color: UIColor.lightGray)
        

    }
    
    @IBAction func addNaviData(){
        //地名を全取得し既存在かどうか判別
        db.collection("place").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var placeId:String?
                for document in querySnapshot!.documents {
                    if document.data()["placeName"] as? String == self.placeTextFeld.text{
                        placeId = document.documentID
                    }
                }
                
                //地名が存在しなかったら新規追加
                if placeId == nil{
                    var ref: DocumentReference?
                    ref = self.db.collection("place").addDocument(data: [
                        "placeName": self.placeTextFeld.text
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(ref!.documentID)")
                        }
                    }
                }
                
                //ナビスキルを追加
                var refTwe: DocumentReference?
                refTwe = self.db.collection("naviSkill").addDocument(data: [
                    "accountId": self.loginId,
                    "placeId": self.loginId,
                    "descliption": self.descriptionTextView.text,
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(refTwe!.documentID)")
                        }
                }
            }
        }
    
        
    }

}
