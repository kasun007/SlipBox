//
//  NoteDetailView.swift
//  SlipBox
//
//  Created by Kasun Wickramanayake on 10/07/23.
//

import SwiftUI

struct NoteDetailView: View {
    
    @ObservedObject var note: Note
    
    var body: some View {
    
        VStack(spacing: 20) {
          
          Text("order \(Int(note.order))")
            
            TextField("title", text: $note.title)
                .textFieldStyle(.roundedBorder)
                .font(.title)
                
            Picker(selection: $note.status) {
                ForEach(Status.allCases) { status in
                    Text(status.rawValue)
                        .tag(status)
                }
            } label: {
                Text("Note´s status")
            }
            .pickerStyle(.segmented)

            HStack {
#if os(iOS)
                TextViewIOSWrapper(note: note)
#else
                TextViewMacosWrapper(note: note)
#endif
             
                Text(note.bodyText)
            }
            
           
            
        }
      .padding()
        
      .onDisappear {
          PersistenceController.shared.save()
      }
        
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let note = Note(title: "New note", context: context)
        
       return NoteDetailView(note: note).environment(\.managedObjectContext, context)
    }
}
