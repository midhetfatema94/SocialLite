//
//  UserDetailView.swift
//  SocialLite
//
//  Created by Waveline Media on 12/23/20.
//

import SwiftUI

struct UserDetailView: View {
    @State var user: User
    var allUsers: [User]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("About: ")
                        .fontWeight(.bold)
                    Text(user.about)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Address: ")
                        .fontWeight(.bold)
                    Text(user.address)
                }
                .padding(.bottom)
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text("Working at:")
                            .fontWeight(.bold)
                        Text(user.company)
                        Text("Age:")
                            .fontWeight(.bold)
                        Text("\(user.age)")
                        Spacer()
                    }
                }
                .padding(.bottom)
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text("Email:")
                            .fontWeight(.bold)
                        Text(user.email)
                        Spacer()
                    }
                }
            }
            .padding()
            
            Text("My friends are: ")
                .font(.title)
                .fontWeight(.bold)
            List {
                ForEach(user.friends, id: \.id) {friend in
                    NavigationLink(
                        destination: UserDetailView(user: getUser(id: friend.id), allUsers: allUsers)) {
                        Text(friend.name)
                    }
                }
            }
        }
        .navigationTitle(user.name)
    }
    
    func getUser(id: String) -> User {
        guard let friendUser = allUsers.first(where: {$0.id == id}) else { return User() }
        return friendUser
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: User(), allUsers: [])
    }
}
