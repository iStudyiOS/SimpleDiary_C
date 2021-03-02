//
//  WeeklyViewController.swift
//  SimpleDiary_C
//
//  Created by 진형진 on 2021/03/01.
//

import UIKit

class WeeklyViewController: UIViewController, UITableViewDelegate, UICollectionViewDelegate {
    
    private lazy var dataSource = WeeklyTableViewDataSource()
    
    @IBOutlet weak var weekTitle: UILabel!
    @IBOutlet weak var weeklyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weekTitle.text = "\(dataSource.dummyData[1].year)년 \(dataSource.dummyData[1].month)월 주간 일정"
        setUpTableView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = dataSource.dummyData[indexPath.row]
        let colors = dataSource.colors
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "weeklyDetailView") as? WeeklyDetailViewController else {
            return
        }
        vc.param = row
        vc.colors = colors
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setUpTableView() {
        weeklyTableView.delegate = self
        weeklyTableView.dataSource = dataSource
        weeklyTableView.reloadData()
    }
    
    
}
