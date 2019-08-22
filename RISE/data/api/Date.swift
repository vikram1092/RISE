import Foundation

// MARK: Time
private let dateFormatterCache = DateFormatterCache()

struct DateFactory {
    /// Shorthand for the day offsets.
    enum Day: Int {
        // NSDatComponents.weekday starts from sunday
        case sunday     = 1
        case monday     = 2
        case tuesday    = 3
        case wednesday  = 4
        case thursday   = 5
        case friday     = 6
        case saturday   = 7
    }
    
    static func dateForNext(day: Day, hour: Int) -> Date? {
        
        let now: Date = Date()
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        
        // First, find the day offset for the next occurance of Day.
        let units: NSCalendar.Unit = [.year, .month, .weekOfMonth, .weekday, .hour]
        let components: DateComponents = (calendar as NSCalendar).components(units,
                                                                             from: now)
        let weekdayToday = components.weekday
        let daysTil = (7 + day.rawValue - weekdayToday!) % 7
        let dayDifference = (60*60*24) * Double(daysTil)
        
        // Then calculate the hour offset.  Target hour + time zone offset - current hour (mod 24)
        let hourOffset = (hour  - components.hour!) % 24
        let hourDifference = Double(hourOffset) * (60*60)
        return now.addingTimeInterval(dayDifference + hourDifference)
    }
}

extension Date {
    /**
     - parameter formatString: [String] which format time string is in. Defaults to 6:00pm format
     - parameter timeZone: [NSTimeZone?] Time zone the date should be displayed in.
     */
    func toString(_ formatString: String, timeZone: TimeZone? = nil) -> String
    {
        return dateFormatterCache.getFormatter(formatString, timeZone: timeZone).string(from: self)
    }
}

extension String {
    /**
     - parameter format: [DateFormat] which format time string is in. Defaults to UTC (API standard)
     */
    func toDate(_ format: DateFormat) -> Date? {
        if let date
            = dateFormatterCache.getFormatter(format.rawValue).date(from: self)
        {
            return date
        } else {
            return nil
        }
    }
}

extension Date {
    /**
     Compares based on year, month, and day but not time of day
     */
    func isSameDay(_ other: Date) -> Bool {
        
        let calendar = Calendar.current
        
        let flags: NSCalendar.Unit = [.year, .month, .day]
        
        let components = (calendar as NSCalendar).components(flags, from: self)
        let otherComponents = (calendar as NSCalendar).components(flags, from: other)
        
        return components.year == otherComponents.year
            && components.month == otherComponents.month
            && components.day == otherComponents.day
    }
}

extension Date {
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
}

class DateFormatterCache {
    
    fileprivate var formatterCache = [String: DateFormatter]()
    
    init() {
        formatterCache = buildFormatters()
    }
    
    fileprivate func buildFormatters() -> [String : DateFormatter] {
        let dateFormats = [DateFormat.kUTCFormat, DateFormat.kTimeFormat, DateFormat.kDateFormat]
        var formatterDict = [String: DateFormatter]()
        for format in dateFormats {
            let formatter = DateFormatter()
            formatter.dateFormat = format.rawValue
            formatterDict[format.rawValue] = formatter
        }
        return formatterDict
    }
    
    func getFormatter(_ format: String, timeZone: TimeZone? = nil) -> DateFormatter {
        if let dateFormatter = formatterCache[format] {
            dateFormatter.timeZone = timeZone
            return dateFormatter
        } else {
            let dateFormatter = DateFormatter()
            formatterCache[format] = dateFormatter
            dateFormatter.timeZone = timeZone
            dateFormatter.dateFormat = format
            return dateFormatter
        }
    }
    
}
