//
//  Task+Convenience.swift
//  TaskCoreData
//
//  Created by lijia xu on 7/27/21.
//

import CoreData

extension Task {
    
    @discardableResult
    convenience init(title: String, notes: String? = nil, dueDate: Date? = nil, isComplete: Bool = false, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = title
        self.notes = notes
        self.dueDate = dueDate
        self.isComplete = isComplete
    }
    
}//End Of Extension
