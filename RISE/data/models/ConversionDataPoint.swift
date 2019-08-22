import ObjectMapper

class ConversionDataPoint: ImmutableMappable {
    var price: Double
    var date: Double
    
    required init(map: Map) throws {
        price = try map.value("price")
        date = try map.value("date")
    }
}
