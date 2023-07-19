//
//  NotesTest.swift
//  SlipBoxTests
//
//  Created by Kasun Wickramanayake on 16/07/23.
//

import XCTest
@testable import SlipBox
import CoreData  

final class NotesTest: XCTestCase {
    
    var controller :PersistenceController! = nil
    
    var context:NSManagedObjectContext{
        
        controller.container.viewContext
    }

    override func setUpWithError() throws {
        
        self.controller = PersistenceController.createEmptyStore()
        
    }

    override func tearDownWithError() throws {
        self.controller = nil
    }

    func test_Notes_Creation(){
        
        let noteTitle = "new"
        let note = Note(title: noteTitle, context: context)
        XCTAssertTrue(note.title == "new" ,"Note Should have the title given in the conveniance initalizer")
    }
    
    func test_Notes_CreationDate(){
        
        let note = Note(context:context)
        let noteConvenient = Note(title: "note", context:context)
        XCTAssertNotNil(note.creationDate,"note should have creationDate properly")
        XCTAssertNotNil(noteConvenient.creationDate)
    }
    
    func test_Notes_Updating_Title(){
        let note = Note(title: "old", context:context)
        note.title = "new"
        XCTAssertTrue(note.title == "new")
        
        
    }
    
    func test_Fetch_All_Notes (){
        let note = Note(title: "default note", context: context)
        let fetch = Note.fetch(.all)
        let fetchedNotes = try? context.fetch(fetch)
        
        XCTAssertNotNil(fetchedNotes)
        XCTAssertTrue(fetchedNotes!.count>0,"Predicate of all should fetch at lest 1 object")
        
    }
    
    func test_Fetc_None_Predicate (){
        let note = Note(title: "default note", context: context)
        let fetch = Note.fetch(.all)
        let fetchedNotes = try? context.fetch(fetch)
        
        XCTAssertNotNil(fetchedNotes)
        XCTAssertTrue(fetchedNotes!.count == 0,"Predicate of none should not fetch any objects ")
        
    }
    
    func test_Delete_Notes(){
        
         let note = Note(title: "default note", context: context)
         Note.delete(note:note)
        
         let fetch = Note.fetch(.all)
         let fetchedNotes = try? context.fetch(fetch)
         XCTAssertTrue(fetchedNotes?.count == 0,"deleted notes should not be in data base")
         XCTAssertTrue(fetchedNotes!.contains(note))
    }
    
    /*func testAsyncronus_save(){
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context){_ in
              return true
        }
        
        let note = Note(title: "default note", context: context)
        controller.save()
        
        waitForExpectations(timeout: 2.0){ error in
            
            XCTAssertNil(error,"saving did not complete")
            
        }
        
    }*/
    
    func test_IsFavourite_Default_Value(){
        
        let note = Note(title: "default note", context: context)
        XCTAssertFalse(note.isFavourite,"note is per default not favorite")
    }
    
    
}
 
