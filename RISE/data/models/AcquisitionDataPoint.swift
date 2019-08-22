import ObjectMapper

class AcquisitionData: ImmutableMappable {
    var list: [AcquisitionDataSet]
    
    required init(map: Map) throws {
        list = try map.value("reverse_search_json")
    }
}

class AcquisitionDataSet: ImmutableMappable {
    var bed: Int
    var currentPrice: Int
    var currentExposure: Int
    var exposures: [String: Int]
    
    required init(map: Map) throws {
        bed = try map.value("bed")
        currentPrice = try map.value("price")
        currentExposure = try map.value("users")
        exposures = try map.value("price_user_predictions")
    }
}
