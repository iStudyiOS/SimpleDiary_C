//
//  CalendarCollectionViewDataSource.swift
//  SimpleDiary_C
//
//  Created by 홍경표 on 2021/02/27.
//

import UIKit

final class CalendarCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var colors: [String: UIColor] = [:]
    
    var dummyData: [Model] = []
    
    let today: (year: Int, month: Int, day: Int) = {
        let comps = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        return (year: comps.year!, month: comps.month!, day: comps.day!)
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    override init() {
        super.init()
        generateDummyData()
    }
    
    func generateDummyData() {
        let beforeMonthLastDay = lastDay(ofMonth: today.month-1, year: today.year)
        if beforeMonthLastDay.weekday != 7 {
            for i in 1...beforeMonthLastDay.weekday {
                dummyData.append(Model(year: today.year, month: today.month-1, day: beforeMonthLastDay.day - beforeMonthLastDay.weekday + i))
            }
        }
        let thisMonthLastDay = lastDay(ofMonth: today.month, year: today.year)
        for i in 1...thisMonthLastDay.day {
            dummyData.append(Model(year: today.year, month: today.month, day: i))
        }
        for i in 1...7 where i + thisMonthLastDay.weekday <= 7 {
            dummyData.append(Model(year: today.year, month: today.month+1, day: i))
            
        }
        
        dummyData.forEach {
            $0.checkList.forEach {
                colors[$0] = UIColor(red: .random(in: 0...1),
                                     green: .random(in: 0...1),
                                     blue: .random(in: 0...1),
                                     alpha: 1.0)
            }
        }
    }
    
    func lastDay(ofMonth m: Int, year y: Int) -> (day: Int, weekday: Int) {
        let cal = Calendar.current
        let comps = DateComponents(calendar: cal, year: y, month: m+1, day: 0)
        let date = cal.date(from: comps)!
        return (cal.component(.day, from: date), cal.component(.weekday, from: date)) // 일, 요일 (1:일요일, 7:토요일)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewDateCell.identifier, for: indexPath) as? CalendarCollectionViewDateCell else {
            return UICollectionViewCell()
        }
        cell.configure(date: dummyData[indexPath.row].day, colors: dummyData[indexPath.row].checkList.sorted().compactMap({ colors[$0] }))
        return cell
    }
    
}

