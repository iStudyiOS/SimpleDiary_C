//
//  WeeklyTableViewDataSource.swift
//  SimpleDiary_C
//
//  Created by 진형진 on 2021/03/01.
//

import UIKit

class WeeklyTableViewDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Properties
    
    var colors: [String: UIColor] = [:]
    var dummyData: [Model] = []
    
    let today: (year: Int, month: Int, day: Int) = {
        let comps = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        return (year: comps.year!, month: comps.month!, day: comps.day!)
    }()
    
    override init() {
        super.init()
        generateDummyData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = dummyData.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = dummyData[indexPath.row]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: "\(row.year)-\(row.month)-\(row.day)")
        let weekDay = Calendar.current.component(.weekday, from: date!)
        var weekDayString: String
        
        switch weekDay {
        case 1: weekDayString = "일요일"
        case 2: weekDayString = "월요일"
        case 3: weekDayString = "화요일"
        case 4: weekDayString = "수요일"
        case 5: weekDayString = "목요일"
        case 6: weekDayString = "금요일"
        case 7: weekDayString = "토요일"
        default: weekDayString = "오류"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weeklyCell") as! WeeklyTableViewDateCell
        
        cell.dateLabel.text = weekDayString + " \(row.month)월 \(row.day)일"
        if weekDay == 1 || weekDay == 7 {
            cell.dateLabel.textColor = .red
        } else {
            cell.dateLabel.textColor = .black
        }
        return cell
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
        return (cal.component(.day, from: date), cal.component(.weekday, from: date))
    }
    
    
}
