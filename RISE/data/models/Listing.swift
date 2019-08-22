import ObjectMapper

class Listing: ImmutableMappable {
    var name: String = ""
    var imageUrl: String = ""
    
    required init(map: Map) throws {
        name = try map.value("name")
        imageUrl = try map.value("imageUrl")
    }
}
