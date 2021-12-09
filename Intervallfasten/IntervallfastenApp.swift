//
//  IntervallfastenApp.swift
//  Intervallfasten
//
//  Created by Galic Dino on 14.10.21.
//


import SwiftUI

@main
struct IntervallfastenApp: App {
   let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

