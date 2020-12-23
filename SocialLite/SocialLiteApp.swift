//
//  SocialLiteApp.swift
//  SocialLite
//
//  Created by Waveline Media on 12/23/20.
//

import SwiftUI

@main
struct SocialLiteApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
