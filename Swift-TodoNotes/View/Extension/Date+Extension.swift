
import UIKit

enum DateFormat: String {
    case localLongDate = "yyyy-MM-dd hh:mm a"
}

extension Date {
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        // 1) Get the current TimeZone's seconds from GMT. Since I am in Chicago this will be: 60*60*5 (18000)
        let timezoneOffset = TimeZone.current.secondsFromGMT()
        // 2) Get the current date (GMT) in seconds since 1970. Epoch datetime.
        let epochDate = self.timeIntervalSince1970
        // 3) Perform a calculation with timezoneOffset + epochDate to get the total seconds for the
        //    local date since 1970.
        //    This may look a bit strange, but since timezoneOffset is given as -18000.0, adding epochDate and timezoneOffset
        //    calculates correctly.
        let timezoneEpochOffset = (epochDate + Double(timezoneOffset))
        // 4) Finally, create a date using the seconds offset since 1970 for the local date.
        return Date(timeIntervalSince1970: timezoneEpochOffset)
    }
    func toLocalDate() -> String {
        // 1) Create a DateFormatter() object.
        let format = DateFormatter()
        // 2) Set the current timezone to .current, or America/Chicago.
        format.timeZone = .current
        // 3) Set the format of the altered date.
        format.dateFormat = DateFormat.localLongDate.rawValue
        // 4) Set the current date, altered by timezone.
        return format.string(from: self)
    }
}
