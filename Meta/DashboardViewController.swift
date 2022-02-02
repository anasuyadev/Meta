//
//  DashboardViewController.swift
//  Meta
//
//  Created by Anasuya Dev on 19/01/22.
//

import UIKit
import MobileCoreServices

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
   
    var currentuserinfo: UserInfo?
     
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentuserinfo = DatabaseHelper.shareInstance.currentUser
        profileImage.layer.borderWidth = 0
        profileImage.layer.masksToBounds = false
//        profileImage.layer.borderColor = UIColor.brown.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
//        profileImage.image = UIImage(data: (currentuserinfo?.img as Data?)!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        currentuserinfo = DatabaseHelper.shareInstance.currentUser
//        DatabaseHelper.shareInstance.updatePic(updatePicUserId: (currentuserinfo?.userid)!, profileImage: profileImage as Any)
        if let pic = currentuserinfo?.img
        {
            profileImage.image = UIImage(data: pic as Data)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func logoutButton(_ sender: UIButton) {
        
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

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        if indexPath.row == 0
        {
            cell.titleLabel.text = "Name "
            cell.outputLabel.text = currentuserinfo?.name
        }
        else if indexPath.row == 1
        {
            cell.titleLabel.text = "Date of Birth "
            cell.outputLabel.text = currentuserinfo?.birthdate
        }
        else if indexPath.row == 2
        {
            cell.titleLabel.text = "User ID "
            cell.outputLabel.text = currentuserinfo?.userid
        }
        else if indexPath.row == 3
        {
            cell.titleLabel.text = "Change password "
            cell.outputLabel.text = "►"
        }
        else if indexPath.row == 4
        {
            cell.titleLabel.text = "Delete User "
            cell.outputLabel.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
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
    }
    
    @IBAction func choosePic(_ sender: UIButton) {
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.allowsEditing = false
//        imagePicker.sourceType = .photoLibrary
//        present(imagePicker, animated: true)
        
    }
    
    
    @IBAction func onClickSelectImage(_ sender: Any) {
        actionSheet()
    }
    
    func actionSheet()
    {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Open Camera", style: .default, handler: {(handler) in
            self.openCamera()
            
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: {(handler) in
            self.openGallery()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {(handler) in}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            let image = UIImagePickerController()
            image.allowsEditing = true
            image.sourceType = .camera
            image.mediaTypes = [kUTTypeImage as String]
            present(image, animated: true, completion: nil)
        }
    }
    
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
           let image = UIImagePickerController()
            image.allowsEditing = true
            image.delegate = self
            present(image, animated: true, completion: nil)
        }
    }
    
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
}

//extension UIImageView{
//    func setRounded()
//    {
//        let radius = CGRectGe
//    }
//}











//        inside infokey -------
//        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
//            profileImage.image = pickedImage
//            DatabaseHelper.shareInstance.image = profileImage.image
//            DatabaseHelper.shareInstance.saveImageInCoreDate()
//        }
//        dismiss(animated: true, completion: nil)
