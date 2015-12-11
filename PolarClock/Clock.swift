import Foundation
import SwiftDate

class Clock {

    var second: Int { return date.second! }
    var minute: Int { return date.minute! }
    var hour: Int { return date.hour! }
    var day: Int { return date.day! }
    var month: Int { return date.month! }
    var daysInMonth: Int { return date.monthDays! }

    var minuteProgress: Double { return Double(second) / 60 }
    var hourProgress: Double { return (Double(minute) + minuteProgress ) / 60 }
    var dayProgress: Double { return (Double(hour) + hourProgress) / 24 }
    var monthProgress: Double { return Double(day-1) / Double(daysInMonth) }
    var yearProgress: Double { return Double(month-1) / 12 }

    private var date: DateInRegion { return NSDate().inRegion(Region.LocalRegion()) }
}