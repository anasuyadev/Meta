//
//  HomeViewController.swift
//  Meta
//
//  Created by Anasuya Dev on 19/01/22.
//

import UIKit
import MobileCoreServices

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
   
    var currentuserinfo: UserInfo?
     
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
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
        currentuserinfo = DatabaseHelper.shareInstance.currentUser
        if let pic = currentuserinfo?.img
        {
            profileImage.image = UIImage(data: pic as Data)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
        return cell
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
