//
//  ChangePasswordViewController.swift
//  Meta
//
//  Created by Anasuya Dev on 20/01/22.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    var currentuserinfo: UserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentuserinfo = DatabaseHelper.shareInstance.currentUser
    }
    
    @IBOutlet weak var currentPasswordField: UITextField!
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
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
