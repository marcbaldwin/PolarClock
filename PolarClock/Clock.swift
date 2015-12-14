import SwiftDate

class Clock {

    var nanosecond: Int { return date.nanosecond! }
    var second: Int { return date.second! }
    var minute: Int { return date.minute! }
    var hour: Int { return date.hour! }
    var day: Int { return date.day! }
    var month: Int { return date.month! }
    var dayOfYear: Int {
        return region.calendar.ordinalityOfUnit(.Day, inUnit: .Year, forDate: date.UTCDate)
    }

    var daysInMonth: Int { return date.monthDays! }
    var daysInYear: Int {
        let endOfYear = date.UTCDate.endOf(.Year, inRegion: region)
        return region.calendar.ordinalityOfUnit(.Day, inUnit: .Year, forDate: endOfYear)
    }

    var secondProgress: Double { return Double(nanosecond) / 1000000000 }
    var minuteProgress: Double { return (Double(second) + secondProgress) / 60 }
    var hourProgress: Double { return (Double(minute) + minuteProgress ) / 60 }
    var dayProgress: Double { return (Double(hour) + hourProgress) / 24 }
    var monthProgress: Double { return (Double(day-1) + dayProgress ) / Double(daysInMonth) }
    var yearProgress: Double { return (Double(dayOfYear-1) + dayProgress ) / Double(daysInYear) }

    private let region: Region = .LocalRegion()
    private var date: DateInRegion { return NSDate().inRegion(region) }
}