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
    
  
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        
        .onChange(of: scenePhase){ newScenePhase in
            
            switch newScenePhase{
                
            case .active :print("app became active")
            case .inactive :print("app became inactive")
            case .background :
                persistenceController.save()
                print("app enterd background")
            @unknown default:
                print("app phase: added unknown cae")
                
                
            }
            
            
            
        }
        .commands {
            
            CommandGroup(replacing: .saveItem){
                Button("Save"){
                    
                    persistenceController.save()
                    
                }
                .keyboardShortcut("S",modifiers: [.command])
                
                
            }
            
            
            
            
        }
    }
}
