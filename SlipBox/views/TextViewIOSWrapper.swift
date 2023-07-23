//
//  TextViewIOSWrapper.swift
//  SlipBox
//
//  Created by Kasun Wickramanayake on 19/07/23.
//

import SwiftUI



struct TextViewIOSWrapper: UIViewRepresentable {
    
    let note: Note
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, note: note)
    }
  
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        
        view.allowsEditingTextAttributes = true
        view.isEditable = true
        view.isSelectable = true
        view.font = UIFont.systemFont(ofSize: 18)
        
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 5
        
        view.textStorage.setAttributedString(note.formattedBodyText)
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.textStorage.setAttributedString(note.formattedBodyText)
        context.coordinator.note = note
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var note: Note
        let parent: TextViewIOSWrapper
        
        init(_ parent: TextViewIOSWrapper, note: Note) {
            self.parent = parent
            self.note = note
        }
        
        func textViewDidChange(_ textView: UITextView) {
            note.formattedBodyText = textView.attributedText
        }
        
    }
}

struct TextViewIOSWrapper_Previews: PreviewProvider {
    static var previews: some View {
        TextViewIOSWrapper(note: Note(title: "note", context: PersistenceController.preview.container.viewContext))
    }
}

