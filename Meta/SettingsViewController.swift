//
//  SettingsViewController.swift
//  Meta
//
//  Created by Anasuya Dev on 04/02/22.
//

import UIKit
import MobileCoreServices

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var currentuserinfo: UserInfo?
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    
    @IBAction func editProfile(_ sender: UIButton) {
        showMiracle()
        userNameLabel.text = currentuserinfo?.name
        if let pic = currentuserinfo?.img
        {
            profileImage.image = UIImage(data: pic as Data)
        }
    }
    
    @IBOutlet weak var settingsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentuserinfo = DatabaseHelper.shareInstance.currentUser
        profileImage.layer.borderWidth = 0
        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)

        userNameLabel.text = currentuserinfo?.name
        let dateOfBirth = currentuserinfo?.birthdate
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        if let date = formatter.date(from: dateOfBirth!)
        {
        
        let today = Date()
        let gregorian = Calendar(identifier: .gregorian)
        let ageComponents = gregorian.dateComponents([.year], from: date, to: Date())
            let age = ageComponents.year!
            ageLabel.text = "\(age) years"
        }
        
        if let pic = currentuserinfo?.img
        {
            profileImage.image = UIImage(data: pic as Data)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc func showMiracle()
    {
     let slideVC = OverlayView()
        slideVC.modalTransitionStyle = .flipHorizontal
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
//        var modalPresent = (self.OverlayView());
//        if modalPresent == true {
        if ((slideVC.isBeingDismissed) != nil){
            userNameLabel.text = currentuserinfo?.name
            if let pic = currentuserinfo?.img
            {
                profileImage.image = UIImage(data: pic as Data)
            }
        }
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
         if indexPath.row == 1
         {
             let storyBoard: UIStoryboard = UIStoryboard(name: "Settings", bundle: nil)
             let vc = storyBoard.instantiateViewController(withIdentifier: "TermsAndConditionsViewController") as! TermsAndConditionsViewController
             self.navigationController?.pushViewController(vc, animated: true)
         }
         if indexPath.row == 2
         {
             let storyBoard: UIStoryboard = UIStoryboard(name: "Settings", bundle: nil)
             let vc = storyBoard.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
             self.navigationController?.pushViewController(vc, animated: true)
         }
         if indexPath.row == 3
         {
            presentShareSheet()
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
    
    @IBOutlet weak var profileImage: UIImageView!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        print(info)
        let data = convertFromUIimageToDict(info)
        if let editingImage = data[convertInfoKey(input: (UIImagePickerController.InfoKey.editedImage))] as? UIImage
        {
            print(editingImage)
            self.profileImage.image = editingImage
            DatabaseHelper.shareInstance.image = profileImage.image
            DatabaseHelper.shareInstance.updatePic(updatePicUserId: (currentuserinfo?.userid)!, profileImageData: (profileImage.image?.jpegData(compressionQuality: 1) as? NSData)!)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func convertFromUIimageToDict( _ input :[UIImagePickerController.InfoKey : Any]) -> [String : Any]
    {
        return Dictionary(uniqueKeysWithValues: input.map({ key, value in (key.rawValue, value)}))
    }
    
    func convertInfoKey(input: UIImagePickerController.InfoKey) -> String
    {
        return input.rawValue
    }
    
    private func presentShareSheet() {
        guard let image = UIImage(systemName: "bell"), let url = URL(string: "https://www.google.com") else {
            return
        }
        let shareSheetVC = UIActivityViewController(
        activityItems: [image,url],applicationActivities: nil)
        present(shareSheetVC, animated: true)
        }
}
extension SettingsViewController: UIViewControllerTransitioningDelegate
{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
