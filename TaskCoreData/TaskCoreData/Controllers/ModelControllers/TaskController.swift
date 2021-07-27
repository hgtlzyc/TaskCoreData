//
//  TaskController.swift
//  TaskCoreData
//
//  Created by lijia xu on 7/27/21.
//

import CoreData

class TaskController {
    
    static let shared = TaskController()
    
    
    private lazy var fetchAllTasksRequest: NSFetchRequest< Task > = {
        let request = NSFetchRequest< Task >(entityName: "Task")
        
        request.predicate = NSPredicate(value: true)
        
        return request
    }()
    
    var tasks: [Task] = []
    
    // MARK: - CRUD Functions
    
    func createTaskWith(name: String, notes: String?, dueDate: Date?){
        Task(title: name, notes: notes, dueDate: dueDate)
        CoreDataStack.saveContextAndFetch()
    }
    
    func fetchTasks(){
        do {
            tasks = try CoreDataStack.context.fetch(fetchAllTasksRequest)
        } catch {
            print("Error Fetch All Tasks",error)
            tasks = []
        }
    }
    
    func update(task: Task, name: String, notes: String?, dueDate: Date?){
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        CoreDataStack.saveContextAndFetch()
    }
    
    func toggleIsComplete(task: Task){
        task.isComplete.toggle()
        CoreDataStack.saveContextAndFetch()
    }
    
    func deleteTask(_ task: Task) {
        CoreDataStack.context.delete(task)
        CoreDataStack.saveContextAndFetch()
    }
    
    
    // MARK: - private init
    private init(){}
    
    
}
