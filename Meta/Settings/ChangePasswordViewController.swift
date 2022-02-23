//
//  ChangePasswordViewController.swift
//  Meta
//
//  Created by Anasuya Dev on 20/01/22.
//

import UIKit

class ChangePasswordViewController: UIViewController, UITextFieldDelegate {

    var currentuserinfo: UserInfo?
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentPasswordField.tag = 0
        self.newPasswordField.tag = 1
        self.confirmPasswordField.tag = 2
        
        self.currentPasswordField.delegate = self
        self.newPasswordField.delegate = self
        self.confirmPasswordField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
        currentuserinfo = DatabaseHelper.shareInstance.currentUser
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
    
    @IBOutlet weak var currentPasswordField: UITextField!
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    @IBAction func iconAction(sender: AnyObject) {
            if(iconClick == true) {
                currentPasswordField.isSecureTextEntry = false

                
            } else {
                currentPasswordField.isSecureTextEntry = true
            }

            iconClick = !iconClick
        }
    
    
    @IBAction func eyeAction(sender: AnyObject) {
            if(iconClick == true) {
                newPasswordField.isSecureTextEntry = false
            } else {
               newPasswordField.isSecureTextEntry = true

            }

            iconClick = !iconClick
        }
    
    @IBAction func eyesAction(sender: AnyObject) {
            if(iconClick == true) {
                confirmPasswordField.isSecureTextEntry = false
            
            } else {
               confirmPasswordField.isSecureTextEntry = true
            }

            iconClick = !iconClick
        }
    
    @IBAction func saveButton(_ sender: UIButton) {
        let password = newPasswordField.text
        if currentPasswordField.text == "" {
            let myAlert = UIAlertController(title: "Current password cannot be empty!", message: "Please enter your password", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){(ACTION) in
                print("OK BUTTON TAPPED")
            }
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        else if newPasswordField.text == "" {
            let myAlert = UIAlertController(title: "New password cannot be empty!", message: "Please enter your password", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){(ACTION) in
                print("OK BUTTON TAPPED")
            }
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        else if !password!.validatePass() {
                let myAlert = UIAlertController(title: "Alert!", message: "Please enter valid password", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){(ACTION) in
                    print("OK BUTTON TAPPED")
                }
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
        }
        else if confirmPasswordField.text == "" {
            let myAlert = UIAlertController(title: "Confirm password cannot be empty!", message: "Please enter your password", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){(ACTION) in
                print("OK BUTTON TAPPED")
            }
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        else if newPasswordField.text != confirmPasswordField.text{
            let myAlert = UIAlertController(title: "Passwords do not match!", message: "", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){(ACTION) in
            print("OK BUTTON TAPPED")
            }
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        else
        {
            let returnValue = DatabaseHelper.shareInstance.retrieve(retrieveUserId: (currentuserinfo?.userid)!)
            if returnValue[0].password != currentPasswordField.text!
            {
                let myAlert = UIAlertController(title: "Wrong password!", message: "Enter your old password correctly", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){(ACTION) in
                print("OK BUTTON TAPPED")
                }
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
            }
            else
            {
                DatabaseHelper.shareInstance.update(updateUserId: (currentuserinfo?.userid)!, modifiedPassword: newPasswordField.text!, confirmModifiedPasword: confirmPasswordField.text!)
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
extension String{
    
    func validatePass(mini: Int = 8, max: Int = 12) -> Bool {
        var passRegEx = ""
        if mini >= max {
            passRegEx =  "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{\(mini),}$"
        }
        else{
            passRegEx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{\(mini),\(max)}$"
        }
        return applyPredicate(regexStr: passRegEx)
    }
    
    func applyPredicate(regexStr: String) -> Bool {
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateOtherString = NSPredicate(format: "SELF MATCHES %@", regexStr)
        let isValidateOtherString = validateOtherString.evaluate(with: trimmedString)
        return isValidateOtherString
    }
}
