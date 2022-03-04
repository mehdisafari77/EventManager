//
//  EventController.swift
//  EventManager
//
//  Created by Mehdi MMS on 04/03/2022.
//

import CoreData

class EventController {
    
    static let shared = EventController()
  
    private lazy var fetchRequest: NSFetchRequest<Event> = {
        let request = NSFetchRequest<Event>(entityName: Strings.event)
        request.predicate = NSPredicate(value: true)
        return request
    } ()
    
    var events: [Event] {
        do {
            return try CoreDataStack.context.fetch(self.fetchRequest)
        } catch {
            print("Error fetching entries: \(error.localizedDescription)")
            return []
        }
    }
    
    // Create
    func createEvent(event: Event){
        CoreDataStack.saveContext()
    }
    
    // Update
    func updateEvent(event: Event, newTitle: String, newDate: Date) {
        event.title = newTitle
        event.date = newDate
        
        CoreDataStack.saveContext()
    }
    
    func toggleIsDone(event: Event) {
        event.isDone.toggle()
        CoreDataStack.saveContext()
    }
    
    // Delete
    func deleteEvent(event: Event) {
        CoreDataStack.context.delete(event)
        CoreDataStack.saveContext()
    }
    
}
