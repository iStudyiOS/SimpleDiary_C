//
//  DailyViewController.swift
//  SimpleDiary_C
//
//  Created by 박진수 on 2021/02/27.
//

import UIKit

class DailyViewController: UIViewController {

    
    @IBOutlet var tableView: UITableView!
    
    var tasks = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tasks"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Setup
        
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
            
        }
        
        // Get all  current saved tasks
        updateTasks()
    }
    
    func updateTasks() {

        tasks.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        for x in 0..<count {
            
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
            }
        }
        
        tableView.reloadData()
        
    }
    @IBAction func didTapAdd(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Task"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
    
extension DailyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension DailyViewController: UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row]
        
        return cell
    }

}

