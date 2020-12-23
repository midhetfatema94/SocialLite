//
//  UserDetailView.swift
//  SocialLite
//
//  Created by Waveline Media on 12/23/20.
//

import SwiftUI

struct UserDetailView: View {
    @State var user: User
    
    var body: some View {
        VStack {
            Text(user.name)
            Text(user.id)
            Text(user.about)
            Text(user.address)
            Text(user.company)
            Text(user.email)
            Text(user.registered)
            Text("\(user.age)")
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: User())
    }
}
