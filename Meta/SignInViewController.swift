//
//  SignInViewController.swift
//  Meta
//
//  Created by Anasuya Dev on 17/01/22.
//

import UIKit
import CoreData

class SignInViewController: UIViewController {
    
    var photos = [UserInfo]()
    var currentuserinfo: UserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentuserinfo = DatabaseHelper.shareInstance.currentUser
//        var data : Data = UIImagePNGRepresentation(image)
    }
    
    @IBOutlet weak var userIDField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func signInButton(_ sender: UIButton) {
        if userIDField.text == "" {
            let myAlert = UIAlertController(title: "User ID cannot be empty!", message: "Please enter User ID", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){(ACTION) in
                print("OK BUTTON TAPPED")
            }
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        else if passwordField.text == "" {
            let myAlert = UIAlertController(title: "Password cannot be empty!", message: "Please enter password", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){(ACTION) in
                print("OK BUTTON TAPPED")
            }
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        else{
        let returnValue = DatabaseHelper.shareInstance.retrieve(retrieveUserId: userIDField.text!)
        if returnValue.count > 0
        {
            if returnValue[0].password == passwordField.text! 
            {
//                let dh = DatabaseHelper()
//                photos = dh.retrieveImage(retrieveUserImage: (currentuserinfo?.userid)!)
//                self.currentuserinfo?.img = photos
                let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
                let myAlert = UIAlertController(title: "Incorrect Password", message: "", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){(ACTION) in
                print("OK BUTTON TAPPED")
                }
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
            }
        }
        else{
            let myAlert = UIAlertController(title: "User ID & Password not correct", message: "", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){(ACTION) in
                print("OK BUTTON TAPPED")
            }
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
    }
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {

    }
}
