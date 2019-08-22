import ObjectMapper

class Listing: ImmutableMappable {
    var name: String
    var imageUrl: String
    var rentalId: String
    
    required init(map: Map) throws {
        name = try map.value("name")
        imageUrl = try map.value("image")
        rentalId = try map.value("rental_id")
    }
}

class Listings: ImmutableMappable {
    var list: [Listing]
    
    required init(map: Map) throws {
        list = try map.value("metro")
    }
}
