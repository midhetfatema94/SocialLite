//
//  ContentView.swift
//  SocialLite
//
//  Created by Waveline Media on 12/23/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: UserDefault.entity(),
        sortDescriptors: [])
    private var coreUsers: FetchedResults<UserDefault>
    
    @State private var users = [User]()

    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.id) { user in
                    NavigationLink(
                        destination: UserDetailView(user: user, allUsers: users),
                        label: {
                            Text(user.name)
                        })
                }
            }
            .onAppear(perform: getUsers)
            .navigationTitle("SocialLite")
        }
    }
    
    func getUsers() {
        if coreUsers.count > 0 {
            self.users = coreUsers.map { $0.getUser() }
        } else {
            let urlString = "https://www.hackingwithswift.com/samples/friendface.json"
            let url = URL(string: urlString)!
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let data = data else {
                    print("No data in response: ", error?.localizedDescription ?? "Unknown error")
                    return
                }
                
                if let decodedOrder = try? JSONDecoder().decode([User].self, from: data) {
                    self.users = decodedOrder
                    self.setPersistentUsers()
                    print("successful response")
                } else {
                    print("Invalid response from server")
                }
            }.resume()
        }
    }
    
    func setPersistentUsers() {
        for eachUser in self.users {
            let newCoreUser = UserDefault(context: self.viewContext)
            newCoreUser.setUser(user: eachUser)
            
            for eachFriend in eachUser.friends {
                let newFriend = FriendDefault(context: self.viewContext)
                newFriend.id = eachFriend.id
                newFriend.name = eachFriend.name
                newFriend.user = newCoreUser
            }
        }
        
        try? self.viewContext.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
