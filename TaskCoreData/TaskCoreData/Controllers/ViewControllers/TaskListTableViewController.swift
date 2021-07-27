//
//  TaskListTableViewController.swift
//  TaskCoreData
//
//  Created by lijia xu on 7/27/21.
//

import UIKit

class TaskListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TaskController.shared.fetchTasks()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        
        cell.task = TaskController.shared.tasks[indexPath.row]
        cell.delegate = self

        return cell
    }
    
    // MARK: - Delete Related
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let choosenTask = TaskController.shared.tasks[indexPath.row]
        switch editingStyle {
        case .delete:
            TaskController.shared.deleteTask(choosenTask)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            return
        }
        
        
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toTaskDetailVC" {
            guard let selectedIndex = tableView.indexPathForSelectedRow,
                  let targetVC = segue.destination as? TaskDetailViewController else { return }
            
            targetVC.task = TaskController.shared.tasks[selectedIndex.row]
            
        }
    }
    
}//End Of VC

extension TaskListTableViewController: TaskCompletionDelegate {
    func taskCellButtonTapped(_ sender: TaskTableViewCell) {
        guard let task = sender.task else { return }
        TaskController.shared.toggleIsComplete(task: task)
        tableView.reloadData()
    }
    
}
