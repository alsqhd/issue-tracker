//
//  DateManager.swift
//  IssueTracker
//
//  Created by 지북 on 2021/06/23.
//

import Foundation

protocol DateManagable {
    
}

extension DateManagable {
    static var issueFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.locale = Locale(identifier: "ko")
        return formatter
    }
    
    static var mileStoneFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko")
        return formatter
    }
    
    func toDate(_ date: String) -> Date {
        if date.contains("Z") {
            return Self.issueFormatter.date(from: date) ?? Date()
        } else {
            return Self.mileStoneFormatter.date(from: date) ?? Date()
        }
    }
    
    func intervalTime(historyTime: String) -> String {
        let time = toDate(historyTime)
        return timeLogic(intervalTime: Int(Date().timeIntervalSince(time)))
    }
    
    private func timeLogic(intervalTime: Int) -> String{
        if intervalTime < 60 {
            return "\(intervalTime)초 전"
        } else if intervalTime < 3600 {
            return "\(intervalTime/60)분 전"
        } else if intervalTime < 216000 {
            return "\(intervalTime/3600)시간 전"
        } else if intervalTime < 12960000 {
            return "\(intervalTime/216000) 일 전"
        } else {
            return "한달 이상 전"
        }
    }
}
