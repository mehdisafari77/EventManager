//
//  CoreDataStack.swift
//  EventManager
//
//  Created by Mehdi MMS on 04/03/2022.
//

import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Strings.appName)
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Error loading persistent store \(error)")
            }
        }
        return container
        
    } ()
    
    static var context: NSManagedObjectContext { return container.viewContext }
    
    static func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                NSLog("Error saving context \(error)")
            }
        }
    }
}
