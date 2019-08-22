import ObjectMapper

class DetailedListing: ImmutableMappable {
    var rentalId: String
    var name: String
    var imageUrl: String
    
    var viewCount90Day: Int
    var interestCount90Day: Int
    var contactCount90Day: Int
    var leaseCount90Day: Int
    
    var viewCount60Day: Int
    var interestCount60Day: Int
    var contactCount60Day: Int
    var leaseCount60Day: Int
    
    var viewCount30Day: Int
    var interestCount30Day: Int
    var contactCount30Day: Int
    var leaseCount30Day: Int
    
    var compCount1Mile: Int
    var compCount2Mile: Int
    var compCount3Mile: Int
    var compCount4Mile: Int
    var compCount5Mile: Int
    
    required init(map: Map) throws {
        rentalId = try map.value("rental_id")
        name = try map.value("name")
        imageUrl = try map.value("image")
        
        viewCount90Day = try map.value("view_count_90_day")
        interestCount90Day = try map.value("interest_count_90_day")
        contactCount90Day = try map.value("contact_count_90_day")
        leaseCount90Day = try map.value("lease_count_90_day")
        
        viewCount60Day = try map.value("view_count_60_day")
        interestCount60Day = try map.value("interest_count_60_day")
        contactCount60Day = try map.value("contact_count_60_day")
        leaseCount60Day = try map.value("lease_count_60_day")
        
        viewCount30Day = try map.value("view_count_30_day")
        interestCount30Day = try map.value("interest_count_30_day")
        contactCount30Day = try map.value("contact_count_30_day")
        leaseCount30Day = try map.value("lease_count_30_day")
        
        compCount1Mile = try map.value("comp_count_1_mi")
        compCount2Mile = try map.value("comp_count_2_mi")
        compCount3Mile = try map.value("comp_count_3_mi")
        compCount4Mile = try map.value("comp_count_4_mi")
        compCount5Mile = try map.value("comp_count_5_mi")
    }
}

//{
//    "rental_id": "p37850",
//    "name": "Avanti Cityside",
//    "image": "98ee539eb842d6c7abf8f80727f7918b",
//    "view_count_90_day": 7693,
//    "interest_count_90_day": 1540,
//    "contact_count_90_day": 381,
//    "lease_count_90_day": 13,
//    "view_count_60_day": 4602,
//    "interest_count_60_day": 888,
//    "contact_count_60_day": 182,
//    "lease_count_60_day": 8,
//    "view_count_30_day": 2140,
//    "interest_count_30_day": 422,
//    "contact_count_30_day": 73,
//    "lease_count_30_day": 8,
//    "comp_count_1_mi": 1,
//    "comp_count_2_mi": 2,
//    "comp_count_3_mi": 6,
//    "comp_count_4_mi": 11,
//    "comp_count_5_mi": 24
//}
