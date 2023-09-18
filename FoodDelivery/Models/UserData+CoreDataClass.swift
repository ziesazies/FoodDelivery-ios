//
//  UserData+CoreDataClass.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 18/09/23.
//
//

import Foundation
import CoreData

@objc(UserData)
public class UserData: NSManagedObject {
    
    class func saveUserData(_ user: User, context: NSManagedObjectContext) -> UserData {
        let request: NSFetchRequest<UserData> = UserData.fetchRequest()
        request.predicate = NSPredicate(format: "userId = %d", user.id)
        
        let userData: UserData
        if let data = try? context.fetch(request).first {
            userData = data
        }
        
        else {
            let entity = NSEntityDescription.entity(forEntityName: "UserData", in: context)!
            userData = NSManagedObject(entity: entity, insertInto: context) as! UserData
        }
        userData.userId = Int64(user.id)
        userData.name = user.name
        userData.email = user.email
        userData.phone = user.phone
        userData.address = user.address
        userData.profileImageUrl = user.profileImage?.url
        if let location = user.location,
            let data = try? JSONEncoder().encode(location) {
            userData.location = data
        }
        else {
            userData.location = nil
        }
        return userData
    }
    
    class func fetchUserData(context: NSManagedObjectContext) -> User? {
        let request: NSFetchRequest<UserData> = UserData.fetchRequest()
//        request.predicate = NSPredicate(format: "userId = %@ AND email = %@", user.id, user.email)
        
        var user: User?
        if let userData = try? context.fetch(request).first {
            user = User(userData: userData)
        }
        
        return user
    }
}
