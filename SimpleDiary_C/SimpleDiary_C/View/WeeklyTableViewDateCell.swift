//
//  WeeklyTableViewDateCell.swift
//  SimpleDiary_C
//
//  Created by 진형진 on 2021/03/01.
//

import UIKit

class WeeklyTableViewDateCell: UITableViewCell {
    
    var colors: [UIColor] = []

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weeklyCollectionView: UICollectionView!
    
}

extension WeeklyTableViewDateCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weeklyCell", for: indexPath)
        cell.backgroundColor = colors[indexPath.row]
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.layer.cornerRadius = cell.frame.width / 3
        return cell
    }
    
}

extension WeeklyTableViewDateCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.height / 2 * 0.9
        let height = collectionView.frame.width / 3 * 0.9
        let oneSize = width > height ? height : width
        return .init(width: oneSize, height: oneSize)
    }
}
