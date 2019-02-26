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
    let loginId = UserDefaults.standard.value(forKey: "UID")
    var ref: DatabaseReference!
    
    @IBOutlet var placeTextFeld:UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeTextFeld.addBorderBottom(height: 0.3, color: UIColor.lightGray)
        ref = Database.database().reference()
    }
    
    @IBAction func addNaviData(){
        if placeTextFeld.text != "",descriptionTextView.text != ""{
            EZFirebaseByKenty.Navigation.addNavigation(placeName: placeTextFeld.text!, description: descriptionTextView.text!)
        }
    }

}
