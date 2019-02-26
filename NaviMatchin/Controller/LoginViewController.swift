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
    @IBOutlet var createBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextFeld.addBorderBottom(height: 0.3, color: UIColor.white)
        familyNameTextFeld.addBorderBottom(height: 0.3, color: UIColor.white)
        emailTextFeild.addBorderBottom(height: 0.3, color: UIColor.white)
        passwordTextFeild.addBorderBottom(height: 0.3, color: UIColor.white)
        passwordSubTextFeild.addBorderBottom(height: 0.3, color: UIColor.white)
        firstNameTextFeld.attributedPlaceholder = NSAttributedString(string: "First Name",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        familyNameTextFeld.attributedPlaceholder = NSAttributedString(string: "Family Name",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        emailTextFeild.attributedPlaceholder = NSAttributedString(string: "Email",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextFeild.attributedPlaceholder = NSAttributedString(string: "Password",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordSubTextFeild.attributedPlaceholder = NSAttributedString(string: "Password (Confirm)",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        createBtn.layer.cornerRadius = 10
        createBtn.layer.borderWidth = 1

    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        if Auth.auth().currentUser != nil {
//            self.performSegue(withIdentifier: "ToComform", sender: nil)
//        }
//    }
    
    @IBAction func imageSetting(){
        let ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        present(ImagePicker, animated: true, completion: nil)
    }
    
    @IBAction func createAccount(){
        if passwordTextFeild.text == passwordSubTextFeild.text{
            EZFirebaseByKenty.Authentication.createAccount(firstName: firstNameTextFeld.text!, lastName: familyNameTextFeld.text!, email: emailTextFeild.text!, password: passwordSubTextFeild.text!) { (status) in
                if status != nil{
                    if status as! Int == 200{
                        self.performSegue(withIdentifier: "ToComform", sender: nil)
                    }
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
