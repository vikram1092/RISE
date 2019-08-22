import ObjectMapper

class TestModel: ImmutableMappable {
    let ping: String
    
    required init(map: Map) throws {
        ping = try map.value("ping")
    }
}
