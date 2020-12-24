//
//  UserDefault+CoreDataProperties.swift
//  SocialLite
//
//  Created by Waveline Media on 12/24/20.
//
//

import Foundation
import CoreData


extension UserDefault {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserDefault> {
        return NSFetchRequest<UserDefault>(entityName: "UserDefault")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: String?
    @NSManaged public var friend: NSSet?
    
    func setUser(user: User) {
        self.id = user.id
        self.name = user.name
        self.isActive = user.isActive
        self.age = Int16(user.age)
        self.company = user.company
        self.email = user.email
        self.address = user.address
        self.about = user.about
        self.registered = user.registered
    }
    
    func getUser() -> User {
        let newUser = User()
        newUser.id = self.id ?? ""
        newUser.name = self.name ?? ""
        newUser.isActive = self.isActive
        newUser.age = Int(self.age)
        newUser.company = self.company ?? ""
        newUser.email = self.email ?? ""
        newUser.address = self.address ?? ""
        newUser.about = self.about ?? ""
        newUser.registered = self.registered ?? ""
        
        let set = self.friend as? Set<FriendDefault> ?? []
        let friendArr = set.sorted { $0.wrappedName < $1.wrappedName }
        newUser.friends = friendArr.map { $0.getFriend() }
        
        return newUser
    }
}

// MARK: Generated accessors for friend
extension UserDefault {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: FriendDefault)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: FriendDefault)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}

extension UserDefault : Identifiable {

}
