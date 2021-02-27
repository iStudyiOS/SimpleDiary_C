//
//  CalendarCollectionViewDateCell.swift
//  SimpleDiary_C
//
//  Created by 홍경표 on 2021/02/27.
//

import UIKit

class CalendarCollectionViewDateCell: UICollectionViewCell {
    
    // MARK: Constants
    
    static let identifier = String(describing: CalendarCollectionViewDateCell.self)
    
    // MARK: Properties
    
    var colors: [UIColor] = []
    
    // MARK: Views
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Initialize
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configure(date: Int, colors: [UIColor]) {
        dateLabel.text = "\(date)"
        self.colors = colors
    }
    
}

extension CalendarCollectionViewDateCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colors[indexPath.row]
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.layer.cornerRadius = cell.frame.width / 3
        return cell
    }
    
}

extension CalendarCollectionViewDateCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.height / 2 * 0.9
        let height = collectionView.frame.width / 3 * 0.9
        let oneSize = width > height ? height : width
        return .init(width: oneSize, height: oneSize)
    }
}
