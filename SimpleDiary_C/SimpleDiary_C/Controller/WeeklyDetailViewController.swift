//
//  WeeklyDetailViewController.swift
//  SimpleDiary_C
//
//  Created by 진형진 on 2021/03/02.
//

import UIKit
import Foundation

class WeeklyDetailViewController: UITableViewController {
    
    var param: Model?
    var colors: [String: UIColor]?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var weeklyTableView: UITableView!
    
    override func viewDidLoad() {
        dateLabel.text = "\(param!.year)년 \(param!.month)월 \(param!.day)일"
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        weeklyTableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let cl = param?.checkList {
            return cl.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sortedChecklist = param!.checkList.sorted(by: <)
        let row = sortedChecklist[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "weeklyDetailCell", for: indexPath) as! WeeklyDetailTableViewCell
        cell.todoLabel.text = row
        cell.colorView.backgroundColor = colors![row]!
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
