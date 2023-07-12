//
//  TESTXApp.swift
//  TESTX
//
//  Created by Kasun Wickramanayake on 11/07/23.
//

import SwiftUI

@main
struct TESTXApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
