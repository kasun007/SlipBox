//
//  ContentView.swift
//  SlipBox
//
//  Created by Kasun Wickramanayake on 9/07/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Note.fetch(.all))
    private var notes: FetchedResults<Note>

    var body: some View {
        NavigationView {
            List {
                ForEach(notes) { note in
                    NavigationLink {
                       NoteDetailView(note: note)
                    } label: {
                        Text(note.creationDate!, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Note", systemImage: "plus")
                    }
                }
            }
            Text("Select an Note")
        }
    }

    private func addItem() {
        withAnimation {
            let newNote = Note(title: "My Note", context: viewContext)
            newNote.creationDate = Date()
        }
    }

    private func deleteItems(offsets: IndexSet) {
         
            offsets.map { notes[$0] }.forEach(viewContext.delete)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
