//
//  EditProfileViewController.swift
//  Meta
//
//  Created by Anasuya Dev on 06/02/22.
//

import UIKit
import MobileCoreServices

class EditProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
   
    var currentuserinfo: UserInfo?
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBAction func onClickSelectImage(_ sender: UIButton) {
        actionSheet()
    }
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
        currentuserinfo = DatabaseHelper.shareInstance.currentUser
        if let pic = currentuserinfo?.img
        {
            profileImage.image = UIImage(data: pic as Data)
        }
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
    
   

