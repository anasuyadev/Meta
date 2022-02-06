//
//  SettingsViewController.swift
//  Meta
//
//  Created by Anasuya Dev on 04/02/22.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var currentuserinfo: UserInfo?
    
    @IBAction func editProfile(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Settings", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBOutlet weak var settingsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentuserinfo = DatabaseHelper.shareInstance.currentUser
    }

    // MARK: - Table view data source

    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell

        if indexPath.row == 0
        {
            cell.titleLabel.text = "Change Password"
        }
         if indexPath.row == 1
         {
             cell.titleLabel.text = "Terms & Conditions"
         }
         if indexPath.row == 2
         {
             cell.titleLabel.text = "Privacy Policy"
         }
         if indexPath.row == 3
         {
             cell.titleLabel.text = "Share"
         }
         if indexPath.row == 4
         {
             cell.titleLabel.text = "Delete User"
         }
         if indexPath.row == 5
         {
             cell.titleLabel.text = "Logout"
         }
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Settings", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 4
        {
            let myAlert = UIAlertController(title: "Delete User", message: "Are you sure want to delete your account?", preferredStyle: UIAlertController.Style.alert)
            let noAction = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel){(ACTION) in
                print("No BUTTON TAPPED")
            }
            let yesAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive){ action -> Void in
                print("Yes BUTTON TAPPED")
                DatabaseHelper.shareInstance.delete(deleteUserId: (self.currentuserinfo?.userid)!)
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            myAlert.addAction(noAction)
            myAlert.addAction(yesAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        if indexPath.row == 5
        {
            let myAlert = UIAlertController(title: "Logout", message: "Are you sure want to logout?", preferredStyle: UIAlertController.Style.alert)
            let noAction = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel){(ACTION) in
                print("No BUTTON TAPPED")
            }
            let yesAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive){ action -> Void in
                print("Yes BUTTON TAPPED")
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            myAlert.addAction(noAction)
            myAlert.addAction(yesAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        
    }
}
