//
//  TaskDetailViewController.swift
//  TaskCoreData
//
//  Created by lijia xu on 7/27/21.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    var task: Task?
    var date: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let task = task else { return }

        taskNameTextField.text = task.name
        taskNotesTextView.text = task.notes
        taskDueDatePicker.date = task.dueDate ?? Date()
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let titleText = taskNameTextField.text, !titleText.isEmpty else { return }
        
        switch task {
        case let task?:
            TaskController.shared.update(task: task,
                                         name: titleText,
                                         notes: taskNotesTextView.text,
                                         dueDate: taskDueDatePicker.date)

        case nil:
            TaskController.shared.createTaskWith(name: titleText,
                                                 notes: taskNotesTextView.text,
                                                 dueDate: date)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func dueDatePickerDateChanged(_ sender: UIDatePicker) {
        date = sender.date
    }
    
}
