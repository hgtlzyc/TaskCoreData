//
//  TaskTableViewCell.swift
//  TaskCoreData
//
//  Created by lijia xu on 7/27/21.
//

import UIKit

protocol TaskCompletionDelegate: AnyObject {
    func taskCellButtonTapped(_ sender: TaskTableViewCell)
}


class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskNameLabel: UILabel!
    
    @IBOutlet weak var completioButton: UIButton!
    
    weak var delegate: TaskCompletionDelegate?
    
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let task = task else { return }
        taskNameLabel.text = task.name
        let image = task.isComplete ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square")
        completioButton.setBackgroundImage(image, for: .normal)
    }
    
    @IBAction func completionButtonTapped(_ sender: Any) {
        delegate?.taskCellButtonTapped(self)
    }
    
}
