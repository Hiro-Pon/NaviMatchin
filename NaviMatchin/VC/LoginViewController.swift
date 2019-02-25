//
//  ViewController.swift
//  NaviMatchin
//
//  Created by 中嶋裕也 on 2019/02/25.
//  Copyright © 2019 hiropon. All rights reserved.
//

import UIKit
import Firebase


class LoginViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet var firstNameTextFeld:UITextField!
    @IBOutlet var familyNameTextFeld:UITextField!
    
    @IBOutlet var emailTextFeild:UITextField!
    @IBOutlet var passwordTextFeild:UITextField!
    @IBOutlet var passwordSubTextFeild:UITextField!
    
    @IBOutlet var profileImageButton:UIButton!
     lazy var db = Firestore.firestore()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageButton.layer.cornerRadius = profileImageButton.bounds.width / 2
        profileImageButton.layer.borderColor = UIColor.gray.cgColor
        profileImageButton.layer.borderWidth = 0.3
        profileImageButton.clipsToBounds = true
        
        firstNameTextFeld.addBorderBottom(height: 0.3, color: UIColor.lightGray)
        familyNameTextFeld.addBorderBottom(height: 0.3, color: UIColor.lightGray)
        emailTextFeild.addBorderBottom(height: 0.3, color: UIColor.lightGray)
        passwordTextFeild.addBorderBottom(height: 0.3, color: UIColor.lightGray)
        passwordSubTextFeild.addBorderBottom(height: 0.3, color: UIColor.lightGray)
        
        firstNameTextFeld.placeholder = "FirstName"
        familyNameTextFeld.placeholder = "FamilyName"
        emailTextFeild.placeholder = "Email"
        passwordTextFeild.placeholder = "Password"
        passwordSubTextFeild.placeholder = "Password(Conform)"
        
    }
    
    
    @IBAction func imageSetting(){
        let ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        present(ImagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func createAccount(){
        
        if passwordTextFeild.text == passwordSubTextFeild.text{
            
            var ref: DocumentReference? = nil
            ref = db.collection("users").addDocument(data: [
                "first": firstNameTextFeld.text,
                "last": familyNameTextFeld.text,
                "email": emailTextFeild.text,
                "password":passwordSubTextFeild.text
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                    UserDefaults.standard.set(ref!.documentID, forKey: "USER_ID")
                    self.performSegue(withIdentifier: "ToComform", sender: nil)
                }
            }
            
        }else{
            print("#PASSWORD_INCORRECT")
            passwordTextFeild.text = ""
            passwordSubTextFeild.text = ""
        }
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        profileImageButton.setImage(image, for: .normal)
        picker.dismiss(animated: true, completion: nil)
    }

}


extension UITextField {
    func addBorderBottom(height: CGFloat, color: UIColor) {
        let border = CALayer()
        self.borderStyle = .none
        border.frame = CGRect(x: 0, y: self.frame.height - height, width: self.frame.width, height: height)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}

