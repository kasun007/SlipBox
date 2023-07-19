//
//  Note+Helper.swift
//  SlipBox
//
//  Created by Kasun Wickramanayake on 10/07/23.
//

import Foundation
import CoreData

extension Note {
    
    
    
    var title:String{
        
        get{
            
            self.title_ ?? ""
        }
        set{
            
            self.title_ = newValue
        }
    }
    
    
    
    var status:Status {
        
        get{
            
            if let rawStatus = status_,
               let status = Status(rawValue: rawStatus){
                
                return status
            }
            
            
            else{
                return Status.draft
                
                
            }
        }
        
        set{
            
            status_ = newValue.rawValue
            
            
            
        }
        
    }
    
    convenience init (title :String,context :NSManagedObjectContext){
        self.init(context:context)
        self.title = title
        
        do {
            
            try context.save()
            
        }catch{
            
            let nsError = error as NSError
            
            fatalError("Unresolved error \(nsError),\(nsError.userInfo )")
            
            
        }
        
    }
    
    public override func awakeFromInsert() {
        self.creationDate = Date()
    }
    
    static func fetch(_ predicate:NSPredicate = .all)->NSFetchRequest<Note> {
        let request = NSFetchRequest<Note>(entityName: "Note")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Note.creationDate,ascending: true)]
        request.predicate = predicate
        
        return request
    }
    
    static func delete(note :Note){
        
        guard  let context = note.managedObjectContext else {return}
        context.delete(note)
    }
    
}
