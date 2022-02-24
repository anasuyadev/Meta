//
//  SignInViewController.swift
//  Meta
//
//  Created by Anasuya Dev on 17/01/22.
//

import UIKit
import CoreData
import LocalAuthentication

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    var photos = [UserInfo]()
    var currentuserinfo: UserInfo?
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
        currentuserinfo = DatabaseHelper.shareInstance.currentUser

        self.userIDField.tag = 0
        self.passwordField.tag = 1
        
        self.userIDField.delegate = self
        self.passwordField.delegate = self
        
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
    
    private func tagBasedTextField(_ textField: UITextField) {
        let nextTextFieldTag = textField.tag + 1

        if let nextTextField = textField.superview?.viewWithTag(nextTextFieldTag) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.tagBasedTextField(textField)
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBOutlet weak var userIDField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func iconAction(sender: AnyObject) {
            if(iconClick == true) {
                passwordField.isSecureTextEntry = false
            } else {
                passwordField.isSecureTextEntry  = true
            }

            iconClick = !iconClick
        }
    
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
    
    @IBAction func facebookLoginButton(_ sender: UIButton) {
    }
    
    @IBAction func googleLoginButton(_ sender: UIButton) {
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {

    }
}
