//
//  SlipBoxApp.swift
//  SlipBox
//
//  Created by Kasun Wickramanayake on 9/07/23.
//

import SwiftUI

@main
struct SlipBoxApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
