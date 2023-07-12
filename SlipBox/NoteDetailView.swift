//
//  NoteDetailView.swift
//  SlipBox
//
//  Created by Kasun Wickramanayake on 10/07/23.
//

import SwiftUI

struct NoteDetailView: View {
    
  @ObservedObject  var note :Note
    var body: some View {
        let textBinding = Binding(get:{note.title ?? ""} ,set:{note.title = $0}
        
        )
        
      return  VStack(spacing:15){
            Text("Note Detail View").font(.title)
            
            HStack {
                Text("Title")
                if let title = note.title {
                    Text(title)
                }
            }
            
            Button("clear title"){
                
                note.title = ""
             }
          TextField("title" ,text : $note.title).textFieldStyle(.roundedBorder)
          
          
            Button("Delete Note"){
                
                let context = note.managedObjectContext
                context?.delete(note )
            }.foregroundColor(.pink)
        }
      .padding()
      .onDisappear{
          
          PersistenceController.shared.save()
          
      }
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let note = Note(title: "New Note", context:context)
       
        return NoteDetailView(note:note).environment(\.managedObjectContext, context)
    }
}
