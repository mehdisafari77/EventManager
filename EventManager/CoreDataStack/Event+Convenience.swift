//
//  Event+Convenience.swift
//  EventManager
//
//  Created by Mehdi MMS on 04/03/2022.
//

import CoreData

extension Event {
    @discardableResult convenience init(title: String, date: Date, isDone: Bool = false, context: NSManagedObjectContext =  CoreDataStack.context) {
        self.init(context: context)
        self.title = title
        self.date = date
        self.isDone = isDone
    }
}
