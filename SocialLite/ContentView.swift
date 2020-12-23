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

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var users = [User]()

    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.id) { user in
                    NavigationLink(
                        destination: UserDetailView(user: user),
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
                print("successful response")
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
