//
//  qualtopApp.swift
//  Shared
//
//  Created by Luis Dominguez on 22/06/22.
//

import SwiftUI

@main
struct qualtopApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
