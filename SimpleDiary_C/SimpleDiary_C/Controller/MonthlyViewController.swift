//
//  MonthlyViewController.swift
//  SimpleDiary_C
//
//  Created by 홍경표 on 2021/02/27.
//

import UIKit

/**
 - 체크리스트를 체크
 */
class MonthlyViewController: UIViewController {

    // MARK: Properties
    
    private lazy var dataSource = CalendarCollectionViewDataSource()
    var pullUpVC: CheckListViewController?
    
    // MARK: Views
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Initialize
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        setUpCollectionView()
        showPullUpVC()
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        collectionView.register(UINib(nibName: CalendarCollectionViewDateCell.identifier, bundle: nil), forCellWithReuseIdentifier: CalendarCollectionViewDateCell.identifier)
    }
    
    func showPullUpVC() {
        guard let pullUpVC: CheckListViewController = storyboard?.instantiateViewController(identifier: CheckListViewController.identifier) as? CheckListViewController else { return }
        self.addChild(pullUpVC)
        let height = view.frame.height * 0.8
        let width = view.frame.width
        pullUpVC.view.frame = CGRect(x: 0, y: view.frame.maxY, width: width, height: height)
        self.view.addSubview(pullUpVC.view)
        pullUpVC.didMove(toParent: self)
        self.pullUpVC = pullUpVC
    }

}
// 셀 클릭 시 이벤트 처리
extension MonthlyViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let date = dataSource.dummyData[indexPath.row]
        pullUpVC?.dateLabel.text = "\(date.year). \(date.month). \(date.day)."
        pullUpVC?.colors = dataSource.colors
        pullUpVC?.models = Array(date.checkList)
    }
}
// 셀 사이즈 고정
extension MonthlyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let oneSize = collectionView.frame.width / 7.0
        return .init(width: oneSize, height: oneSize)
    }
}
