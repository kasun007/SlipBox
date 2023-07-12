//
//  TestApp.swift
//  Test
//
//  Created by Kasun Wickramanayake on 11/07/23.
//

import SwiftUI

@main
struct TestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
