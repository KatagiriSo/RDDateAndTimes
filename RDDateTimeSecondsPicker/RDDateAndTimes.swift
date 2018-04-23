//
//  RDDateAndTimes.swift
//  RDDateTimeSecondsPicker
//
//  Created by KatagiriSo on 2018/04/23.
//  Copyright © 2018年 KatagiriSo. All rights reserved.
//

import Foundation

class RDDateAndTimes {
    let seconds:[Int] = ([Int])(0..<60).map { $0 }
    let minutes:[Int] = ([Int])(0..<60).map { $0 }
    let hours:[Int] = ([Int])(0..<24).map { $0 }
    let dates:[Date]
    let now:Date
    let dateFormatter:DateFormatter
    var dispDates:[String]? = nil
    var dispSeconds:[String]? = nil
    var dispMinutes:[String]? = nil
    var dispHours:[String]? = nil
    
    enum Index:Int {
        case date = 0
        case hour = 1
        case minute = 2
        case second = 3
        
        static func count() -> Int {
            return 4
        }
        static func list() -> [Index] {
            return [.date, .hour, .minute, .second ]
        }
    }
    
    private static func makeDates(now:Date) ->[Date]  {
        let calender = Calendar(identifier: .gregorian)
        let oneYearAgo = calender.date(byAdding: .year, value: -1, to: now)
        var dates:[Date] = []
        for day in 1...365 {
            let date = calender.date(byAdding: .day, value: day, to: oneYearAgo!)
            dates.append(date!)
        }
        return dates
    }
    
    private static func makeDateFormmater() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = "MM/dd(EEE)"
        return dateFormatter
    }
    
    init(now:Date = Date(), dateFormatter:DateFormatter = RDDateAndTimes.makeDateFormmater()) {
        self.now = now
        self.dates = type(of:self).makeDates(now: now)
        self.dateFormatter = dateFormatter
    }
    
    func displayDates() -> [String] {
        if let ds = self.dispDates {
            return ds
        }
        let ds = dates.map { dateFormatter.string(from: $0)}
        self.dispDates = ds
        return ds
    }
    
    func displayMinutes() -> [String] {
        if let dm = self.dispMinutes {
            return dm
        }
        let dm = minutes.map { "\($0)"}
        self.dispMinutes = dm
        return dm
    }
    
    func displaySeconds() -> [String] {
        if let ds = self.dispSeconds {
            return ds
        }
        let ds = seconds.map { "\($0)"}
        self.dispSeconds = ds
        return ds
    }
    
    func displayHours() -> [String] {
        if let dh = self.dispHours {
            return dh
        }
        let dh = hours.map { "\($0)"}
        self.dispHours = dh
        return dh
    }
    
    func row(index:Index, date:Date) -> Int? {
        let calender = Calendar(identifier: .gregorian)
        
        switch index {
        case .date:
            let dateStr = dateFormatter.string(from: date)
            return self.displayDates().index { $0 == dateStr }
        case .hour:
            let comp = calender.component(.hour, from: date)
            return self.hours.index { $0 == comp }
        case .minute:
            let comp = calender.component(.minute, from: date)
            return self.minutes.index { $0 == comp }
        case .second:
            let comp = calender.component(.second, from: date)
            return self.seconds.index { $0 == comp }
        }
    }
    
    func nowRow(index:Index) -> Int? {
        return row(index: index, date: self.now)
    }
    
    func selectDate(indexList:[Int]) -> Date? {
        let calender = Calendar(identifier: .gregorian)
        // date取得
        let date = dates[indexList[Index.date.rawValue]]
        let year = calender.component(.year, from: date)
        let month = calender.component(.month, from: date)
        let day = calender.component(.day, from: date)
        
        let hour = hours[indexList[Index.hour.rawValue]]
        let minute = minutes[indexList[Index.minute.rawValue]]
        let second = seconds[indexList[Index.second.rawValue]]
        
        let d:DateComponents = DateComponents(calendar: calender,
                                              timeZone: nil,
                                              era: nil,
                                              year: year,
                                              month: month,
                                              day: day,
                                              hour: hour,
                                              minute: minute,
                                              second: second,
                                              nanosecond: nil,
                                              weekday: nil,
                                              weekdayOrdinal: nil,
                                              quarter: nil,
                                              weekOfMonth: nil,
                                              weekOfYear: nil,
                                              yearForWeekOfYear: nil)
        return d.date
    }
    
    
    
}

extension RDDateAndTimes {
    func display(index:Index) -> [String] {
        switch index {
        case .date:
            return self.displayDates()
        case .hour:
            return self.displayHours()
        case .minute:
            return self.displayMinutes()
        case .second:
            return self.displaySeconds()
        }
    }
}
