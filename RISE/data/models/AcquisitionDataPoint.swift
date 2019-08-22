import ObjectMapper

class AcquisitionDataPoint: ImmutableMappable {
    var price: Double
    var exposure: Double
    
    required init(map: Map) throws {
        price = try map.value("price")
        exposure = try map.value("exposure")
    }
}
