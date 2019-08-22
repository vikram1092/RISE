
public enum BedroomSize: Int, CaseIterable {
    case Zero = 0
    case One
    case Two
    case Three
    
    func name() -> String {
        switch self {
        case .Zero:
            return "Studio"
        case .One:
            return "1 Bedroom"
        case .Two:
            return "2 Bedroom"
        case .Three:
            return "3 Bedroom"
        }
    }
    
    static func from(name: String) -> BedroomSize {
        return BedroomSize.allCases
            .first(where: { $0.name() == name }) ?? BedroomSize.One
    }
}

public enum DetailMode: String, CaseIterable {
    case Exposure = "exposure"
    case Interests = "positive_interests"
    case Contacts = "contacts"
    case Rank = "rank"
    
    func name() -> String {
        switch self {
        case .Exposure:
            return "Exposure"
        case .Interests:
            return "Positive Interests"
        case .Contacts:
            return "Contacts"
        case .Rank:
            return "Rank"
        }
    }
    
    static func from(name: String) -> DetailMode {
        return DetailMode.allCases
            .first(where: { $0.name() == name }) ?? DetailMode.Interests
    }
}

public enum MileageMode: Int, CaseIterable {
    case One = 1
    case Two
    case Three
    case Four
    case Five
    
    func name() -> String {
        switch self {
        case .One:
            return "1 Mile"
        case .Two:
            return "2 Miles"
        case .Three:
            return "3 Miles"
        case .Four:
            return "4 Miles"
        case .Five:
            return "5 Miles"
        }
    }
    
    static func from(name: String) -> MileageMode {
        return MileageMode.allCases
            .first(where: { $0.name() == name }) ?? MileageMode.One
    }
}

enum DateFormat: String {
    case kDateFormat = "yyyy-MM-dd"
    case kTimeFormat = "h:mma"
    case kUTCFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXX"
    case kDayFormat = "EEEE"
    case k24HourTimeFormat = "HH:mm"
    case kMonthDayFormat = "EEEE, MMM dd, yyyy"
    case kMonthDayAtHourFormat = "MMMM d 'at' h:mm a"
    case kMonthDateFormat = "MMM d"
}

enum DashboardState {
    case Performance
    case Geography
    case Competition
}

enum Duration: Int, CaseIterable {
    case Ninety = 90
    case Sixty = 60
    case Thirty = 30
    
    func name() -> String {
        switch self {
        case .Ninety:
            return "90 days"
        case .Sixty:
            return "60 days"
        case .Thirty:
            return "30 days"
        }
    }
    
    static func from(name: String) -> Duration {
        return Duration.allCases
            .first(where: { $0.name() == name }) ?? Duration.Ninety
    }
}
