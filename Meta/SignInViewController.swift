//
//  SignInViewController.swift
//  Meta
//
//  Created by Anasuya Dev on 17/01/22.
//

import UIKit
import CoreData
import LocalAuthentication

class SignInViewController: UIViewController {
    
    var photos = [UserInfo]()
    var currentuserinfo: UserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentuserinfo = DatabaseHelper.shareInstance.currentUser
        let logindetails = UserDefaults.standard.value(forKey: "userid")
        if logindetails != nil
        {
        userIDField.text = UserDefaults.standard.value(forKey: "userid") as? String
        passwordField.text = UserDefaults.standard.value(forKey: "password") as? String
        }
        else
        {
            userIDField.text = ""
            passwordField.text = ""
        }
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
                let context = LAContext()
                var error: NSError? = nil
                if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error:  &error)
                {
                    let reason = "Please authorize it with a touch Id!"
               context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
                        DispatchQueue.main.async{
                        guard success, error == nil else{
                            // failed
                    let myAlert = UIAlertController(title: "Failed to Authenticate!", message: "Please try again", preferredStyle: UIAlertController.Style.alert)
                            myAlert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))

                            self?.present(myAlert, animated: true)
                            
                            return
                        }
                        //show other screen
                        //success
                            let alert = UIAlertController(title: "Saving", message: "Do You Want To Save Login Details", preferredStyle: .alert)
                                
                            let yesbutton = UIAlertAction(title: "YES", style: .default){ (action) in
                                
                                UserDefaults.standard.set(self!.userIDField.text!, forKey: "userid")
                                UserDefaults.standard.set(self!.passwordField.text!, forKey: "password")
                                
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyBoard.instantiateViewController(withIdentifier: "TabBar")
                                self?.navigationController?.pushViewController(vc, animated: true)
                            
                                }
                            let nobutton = UIAlertAction(title: "NO", style: .default) {    (action) in
                                    print("You Have Not Saved Login Details")
                                    
                                
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyBoard.instantiateViewController(withIdentifier: "TabBar")
                                self?.navigationController?.pushViewController(vc, animated: true)
                            
                              // self.performSegue(withIdentifier: "HomeViewController" , sender: self)
                                }
                                alert.addAction(yesbutton)
                                alert.addAction(nobutton)
                                self!.present(alert,animated: true, completion: nil)
                    }
                    }
                }
                else{
                    // can not use
                    let myAlert = UIAlertController(title: "Unavailable!", message: "You can't use this feature", preferredStyle: UIAlertController.Style.alert)
                        myAlert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))

                            present(myAlert, animated: true)
                }
//                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyBoard.instantiateViewController(withIdentifier: "TabBar")
//                self.navigationController?.pushViewController(vc, animated: true)
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
