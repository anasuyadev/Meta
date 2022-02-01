//
//  UserInfo+CoreDataProperties.swift
//  Meta
//
//  Created by Anasuya Dev on 19/01/22.
//
//

import Foundation
import CoreData


extension UserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }

    @NSManaged public var password: String?
    @NSManaged public var userid: String?
    @NSManaged public var name: String?
    @NSManaged public var birthdate: String?
    @NSManaged public var confirmpassword: String?
    @NSManaged public var img: NSData?


}

extension UserInfo : Identifiable {

}
