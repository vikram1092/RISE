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
    case Leases = "leases"
    
    func name() -> String {
        switch self {
        case .Exposure:
            return "Exposure"
        case .Interests:
            return "Positive Interests"
        case .Contacts:
            return "Contacts"
        case .Leases:
            return "Leases"
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
