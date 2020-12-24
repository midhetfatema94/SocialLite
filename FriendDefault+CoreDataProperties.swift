//
//  FriendDefault+CoreDataProperties.swift
//  SocialLite
//
//  Created by Waveline Media on 12/24/20.
//
//

import Foundation
import CoreData


extension FriendDefault {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendDefault> {
        return NSFetchRequest<FriendDefault>(entityName: "FriendDefault")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var user: UserDefault?
    
    public var wrappedName: String {
        name ?? "Unknown Friend"
    }
    
    func getFriend() -> Friend {
        let friend = Friend()
        friend.id = self.id ?? ""
        friend.name = self.wrappedName
        return friend
    }
}

extension FriendDefault : Identifiable {

}
