//
//  DateUtilities.swift
//  NewMarketServices
//
//  Created by RAMESH on 3/29/18.
//  Copyright © 2018 virtusa. All rights reserved.
//

import Foundation

class DateUtilities: NSObject {
    private static let formats: [String]  = [
        "yyyy-MM-dd'T'HH:mm:ss'Z'",   "yyyy-MM-dd'T'HH:mm:ssZ",
        "yyyy-MM-dd'T'HH:mm:ss",      "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
        "yyyy-MM-dd'T'HH:mm:ss.SSSZ", "yyyy-MM-dd HH:mm:ss",
        "MM/dd/yyyy HH:mm:ss",        "MM/dd/yyyy'T'HH:mm:ss.SSS'Z'",
        "MM/dd/yyyy'T'HH:mm:ss.SSSZ", "MM/dd/yyyy'T'HH:mm:ss.SSS",
        "MM/dd/yyyy'T'HH:mm:ssZ",     "MM/dd/yyyy'T'HH:mm:ss",
        "yyyy:MM:dd HH:mm:ss",        "yyyyMMdd" ];
    
    static func formattedDate(_ dateString: String, dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")! //local
        let dataDate = dateFormatter.date(from:dateString)
        
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "en_US_POSIX")
        formatter.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        formatter.timeZone = TimeZone(abbreviation: "UTC")! //local
        formatter.dateFormat = dateFormat
        return formatter.string(from: dataDate!)
    }
    
    static func hoursDifferenceBetweenDates(fromDateString : String , toDateString: String) -> Int? {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm a"

        // 07-17-2018 02:33 PM
        
        //07-17-2018 02:33 PM
        //        let startDateString = "2018-07-31 10:11:12"
        guard let startDate = dateFormatter.date(from: fromDateString) else { return nil }
        guard let endDate = dateFormatter.date(from: toDateString) else { return nil }
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour], from: startDate, to: endDate)
        guard let hours = dateComponents.hour else {
            return nil
        }
        print("hours: \(hours)")
        return hours
    }
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the amount of nanoseconds from another date
    func nanoseconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.nanosecond], from: date, to: self).nanosecond ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        if nanoseconds(from: date) > 0 { return "\(nanoseconds(from: date))ns" }
        return ""
    }
    
    
    
}


