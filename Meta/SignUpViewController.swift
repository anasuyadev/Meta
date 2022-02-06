//
//  SignOutViewController.swift
//  Meta
//
//  Created by Anasuya Dev on 17/01/22.
//

import UIKit
class SignUpViewController: UIViewController {
    
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var birthDateField: UITextField!
    @IBOutlet weak var userIDField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    
    @IBAction func signUpButton(_ sender: UIButton) {
        let password = passwordField.text
        if nameField.text == "" {
            let myAlert = UIAlertController(title: "User name cannot be empty!", message: "Please enter your name", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){(ACTION) in
                print("OK BUTTON TAPPED")
            }
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        else if nameField.text!.count < 3 {
            let myAlert = UIAlertController(title: "Invalid User name!", message: "User name should be more than 2 characters", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){(ACTION) in
                print("OK BUTTON TAPPED")
            }
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        else if userIDField.text == "" {
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
        else if !password!.validatePassword() {
                let myAlert = UIAlertController(title: "Alert!", message: "Please enter valid password", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){(ACTION) in
                    print("OK BUTTON TAPPED")
                }
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
        }
        else if confirmPasswordField.text == "" {
            let myAlert = UIAlertController(title: "Confirm password cannot be empty!", message: "Please enter confirm password", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){(ACTION) in
                print("OK BUTTON TAPPED")
            }
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        else if passwordField.text != confirmPasswordField.text{
            let myAlert = UIAlertController(title: "Passwords do not match!", message: "", preferredStyle: UIAlertController.Style.alert)
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
                let myAlert = UIAlertController(title: "User account already exists!", message: "Please Sign in", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){(ACTION) in
                    print("OK BUTTON TAPPED")
                }
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
            }
        else{
            let dict = ["name":nameField.text, "birthdate":birthDateField.text, "userid":userIDField.text,"password":passwordField.text, "confirmpassword":confirmPasswordField.text]
            DatabaseHelper.shareInstance.save(object: dict as! [String:String])
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    }
    @IBAction func signInButton(_ sender: UIButton) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
    }
    
    @objc func dateChange()
       {
           birthDateField.text = formatDate()
       }
       func formatDate() -> String
       {
           let formatter = DateFormatter()
           formatter.dateFormat = "dd MMM yyyy"
           return formatter.string(from: datePicker.date)
       }
    
}

extension String{
    
    func validatePassword(mini: Int = 8, max: Int = 12) -> Bool {
        var passRegEx = ""
        if mini >= max {
            passRegEx =  "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{\(mini),}$"
        }
        else{
            passRegEx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{\(mini),\(max)}$"
        }
        return applyPredicateOnRegex(regexStr: passRegEx)
    }
    
    func applyPredicateOnRegex(regexStr: String) -> Bool {
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateOtherString = NSPredicate(format: "SELF MATCHES %@", regexStr)
        let isValidateOtherString = validateOtherString.evaluate(with: trimmedString)
        return isValidateOtherString
    }
}















//override func viewDidLoad() {
//    super.viewDidLoad()

//        let datepicker = UIDatePicker()
//    datePicker.datePickerMode = .date
//        datepicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
//        datepicker.frame.size = CGSize(width: 0, height: 300)
//        datepicker.preferredDatePickerStyle = .wheels
//        datepicker.maximumDate = Date()
//        birthDateField.inputView = datepicker

//}

//    @objc func dateChange(datePicker: UIDatePicker)
//    {
//        birthDateField.text = formatDate(date: datePicker.date)
//    }
//    func formatDate(date: Date) -> String
//    {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd MMM yyyy"
//        return formatter.string(from: date)
//    }
//func formatDate() -> String
//{
//    let formatter = DateFormatter()
//          formatter.dateFormat = "EEE"
//           let dayName = formatter.string(from: datePicker.date)
//          print(dayName)
//    formatter.dateStyle = .medium
//    formatter.dateFormat = "dd MMM YYYY"
//    let monthFormat = formatter.string(from: datePicker.date)
//    return "\(monthFormat)"
//}
