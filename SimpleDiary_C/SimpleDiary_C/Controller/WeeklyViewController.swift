//
//  WeeklyViewController.swift
//  SimpleDiary_C
//
//  Created by 진형진 on 2021/03/01.
//

import UIKit

class WeeklyViewController: UIViewController, UITableViewDelegate, UICollectionViewDelegate {
    
    @IBOutlet weak var weekTitle: UILabel!
    private lazy var dataSource = WeeklyTableViewDataSource()
    
    @IBOutlet weak var weeklyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        
    }
    private func setUpTableView() {
        weeklyTableView.delegate = self
        weeklyTableView.dataSource = dataSource
        weeklyTableView.reloadData()
    }
}
