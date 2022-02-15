//
//  DatabaseHelper.swift
//  Meta
//
//  Created by Anasuya Dev on 18/01/22.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper
{
    var image:UIImage?=nil
    var currentUser: UserInfo?
    static var shareInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    func save(object:[String:String])
    {
        let userInfo = NSEntityDescription.insertNewObject(forEntityName: "UserInfo", into: context!) as! UserInfo
        userInfo.name = object["name"]
        userInfo.birthdate = object["birthdate"]
        userInfo.userid = object["userid"]
        userInfo.password = object["password"]
        userInfo.confirmpassword = object["confirmpassword"]
        currentUser = userInfo
        do{
            try context?.save()
            print("Data saved")
        }
        catch
        {
            print("Data not saved")
        }
    }
    
    func retrieve(retrieveUserId: String) -> [UserInfo]
    {
        var userInfo: [UserInfo]!
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserInfo")
        let predicate = NSPredicate(format: "userid == %@", retrieveUserId)
        fetchRequest.predicate = predicate
        
        do{
            userInfo = try context?.fetch(fetchRequest) as! [UserInfo]
            if let userInfoVar = userInfo, userInfoVar.count > 0
            {
                currentUser = userInfoVar[0]
            }
        }
        catch{
            print("Data not fetched")
        }
        return userInfo
    }
    
    func delete(deleteUserId: String)
    {
        var userInfo = retrieve(retrieveUserId: deleteUserId)
        context?.delete(userInfo[0])
        userInfo.remove(at: 0)
        do{
            try context?.save()
            print("Data deleted")

        }
        catch{
            print("Data not deleted")
        }
    }
    
    func update(updateUserId: String, modifiedPassword: String, confirmModifiedPasword: String)
    {
        let userInfo = retrieve(retrieveUserId: updateUserId)
        userInfo[0].password = modifiedPassword
        userInfo[0].confirmpassword = confirmModifiedPasword
        do{
            try context?.save()
            
        }
        catch{
            print("Data not edited")
        }
    }
//    update func for img
    func updatePic(updatePicUserId:  String, profileImageData: NSData)
    {
        let userInfo = retrieve(retrieveUserId: updatePicUserId)
        userInfo[0].img = profileImageData
        currentUser = userInfo[0]
        do{
            try context?.save()
            print("Pic saved")
        }
        catch{
            print("Pic not saved")
        }
    }
    func editProfile(editUserID: String, editedName: String)
    {
        let userInfo = retrieve(retrieveUserId: editUserID)
        userInfo[0].name = editedName
        currentUser = userInfo[0]
        do{
            try context?.save()
            
        }
        catch{
            print("Data not edited")
        }
    }
   
}








//not a dict, only string
//        extract using userid
//        parameters pass, userid
//        let managedObjectContext: NSManagedObjectContext
//        let predicate = NSPredicate(format: "userid == %@", userid)
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "UserInfo")
//        fetchRequest.predicate = predicate
//        let results = managedObjectContext.execute(fetchRequest)
        

//            let result = try context?.fetch(UserInfo.fetchRequest()) as? [UserInfo]
            
//            for item in result!
//            {
//                print(item.name!)
//                print(item.birthdate!)
//                print(item.userid!)
//                print(item.password!)
//                print(item.confirmpassword!)
//            }
//    func retrive()
//    {
//        let fetchRequest: NSFetchRequest<UserInfo> = UserInfo.fetchRequest()
//        do{
//            try context?.save()
//        }
//        catch
//        {
//            print("Data not saved")
//        }
//    return fetchRequest
//    }
//func delete()
//{
//    do{
//        let items = try context?.fetch(UserInfo.fetchRequest()) as! [UserInfo]
//        for item in items
//        {
//            context?.delete(item)
//        }
//        try context?.save()
//        print("Data deleted")
//    }
//    catch{
//        print("Data not deleted")
//    }
//}
//    func retrieveImage(retrieveUserImage: String) -> UIImage
//    {
//        var photos: UIImage
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserInfo")
//        let predicate = NSPredicate(format: "userid == %@", retrieveUserImage)
//        fetchRequest.predicate = predicate
//        do{
//            photos = try context?.fetch(fetchRequest) as! UIImage
//            currentUser = photos
//        }
//        catch
//        {
//            print("Error while fetching image")
//        }
//        return photos
//    }
    
