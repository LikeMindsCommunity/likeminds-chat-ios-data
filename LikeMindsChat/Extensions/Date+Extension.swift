//
//  Date+Extension.swift
//  LMFeed
//
//  Created by Pushpendra Singh on 23/02/23.
//

import Foundation

extension Date {
    var millisecondsSince1970: Double {
        return (self.timeIntervalSince1970 * 1000.0).rounded()
    }
    init(milliseconds: Double) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds)/1000.0)
    }
    func getDateInFormateWith(withMillSec: Double, format: String = "MM-dd-yyyy") -> String {
        let date = Date(milliseconds: withMillSec).description
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        let date1 = dateFormatter.date(from: date)
        dateFormatter.dateFormat = format
        let date2 = dateFormatter.string(from: date1!)
        return date2
    }
    func convertDateFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date1 = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let date2 = dateFormatter.string(from: date1!)
        return date2
    }
}

struct TimeUtil {
    
    private static let APPROX_INITIAL_LAUNCH_MILLIS = 1546281000000
    
    //to check whether [time] is on millisecond or not
    static func isInMillis(_ time: Int) -> Bool {
        return time > APPROX_INITIAL_LAUNCH_MILLIS
    }
    
}
