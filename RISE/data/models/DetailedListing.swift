import ObjectMapper

class DetailedListing: ImmutableMappable {
    var name: String
    
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
    
    var avgRank90day: Int
    var avgRank60day: Int
    var avgRank30day: Int
    
    static let range = Array(0...90)
    var avgRankPerDay: [Int] //= DetailedListing.range.map { _ in Int.random(in: 1...9) }
    var avgExposurePerDay: [Int] = DetailedListing.range.map { _ in Int.random(in: 1000...3000) }
    var avgInterestsPerDay: [Int] = DetailedListing.range.map { _ in Int.random(in: 50...500) }
    var avgContactsPerDay: [Int] = DetailedListing.range.map { _ in Int.random(in: 20...200) }
    
    var avgPricePerDay: [Int] = DetailedListing.range.map { _ in Int.random(in: 700...1500) }
    var avgMarketPricePerDay: [Int] = DetailedListing.range.map { _ in Int.random(in: 700...1500) }
    var acquisitionData: [AcquisitionDataSet]
    
    required init(map: Map) throws {
        name = try map.value("name")
        
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
        
        avgRank90day = try map.value("avg_rank_90_day")
        avgRank60day = try map.value("avg_rank_60_day")
        avgRank30day = try map.value("avg_rank_30_day")
        
        let avgRankPerDayString: String = try map.value("avg_rank_per_day")
        let avgExposurePerDayString: String = try map.value("view_count_per_day")
        let avgInterestsPerDayString: String = try map.value("interest_count_per_day")
        let avgContactsPerDayString: String = try map.value("contact_count_per_day")

        avgRankPerDay = avgRankPerDayString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgExposurePerDay = avgExposurePerDayString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgInterestsPerDay = avgInterestsPerDayString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgContactsPerDay = avgContactsPerDayString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        
        acquisitionData = try map.value("reverse_search_json")
//        avgPricePerDay = try map.value("avg_price_per_day")
//        avgMarketPricePerDay = try map.value("avg_market_price_per_day")
    }
}

//let sampleAcqData = ["reverse_search_json":[["bed":2,"price":1568,"users":1837,"price_user_predictions":["1000":5363,"1100":4793,"1200":4491,"1300":3745,"1400":3228,"1500":2602,"1600":1837,"1700":1431,"1800":1201,"1900":940,"2000":871,"2100":653,"2200":628,"2300":593,"2400":578,"2500":558,"2600":508,"2700":498,"2800":493,"2900":493,"3000":478,"3100":460,"3200":460,"3300":460,"3400":460,"3500":460,"3600":460,"3700":450,"3800":450,"3900":450,"4000":450,"4100":450,"4200":450,"4300":450,"4400":450,"4500":450,"4600":450,"4700":450,"4800":445,"4900":445,"5000":445,"5100":445,"5200":445,"5300":445,"5400":445,"5500":445,"5600":445,"5700":445,"5800":445,"5900":445,"6000":440]],["bed":1,"price":1314,"users":2180,"price_user_predictions":["1000":5228,"1100":4103,"1200":3421,"1300":2535,"1400":2180,"1500":1847,"1600":1599,"1700":1509,"1800":1459,"1900":1394,"2000":1389,"2100":1329,"2200":1324,"2300":1324,"2400":1314,"2500":1304,"2600":1304,"2700":1304,"2800":1304,"2900":1294,"3000":1294,"3100":1289,"3200":1289,"3300":1284,"3400":1284,"3500":1284,"3600":1279,"3700":1279,"3800":1279,"3900":1279,"4000":1279,"4100":1279,"4200":1279,"4300":1279,"4400":1279,"4500":1279,"4600":1279,"4700":1279,"4800":1279,"4900":1279,"5000":1274,"5100":1274,"5200":1274,"5300":1274,"5400":1274,"5500":1274,"5600":1274,"5700":1274,"5800":1274,"5900":1274,"6000":1259]]]]


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
//contact_count_per_day  | 1,2,2,1,1,3,2,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,2,1,2,1,2,1,1,1,1,1,3,1,1,1,1,1,1,1,1,1,1
//interest_count_per_day | 1,2,3,1,2,2,1,1,1,2,1,2,3,3,6,1,1,1,1,2,3,3,1,1,4,2,2,2,1,3,1,1,2,3,3,1,2,4,2,2,1,2,5,2,1,1,5,3,2,2,3,1,3,3,2,1,3,4,2,1,2,1,2,1,2,1,1,3,1,1,1,1,2,1,2,1
//view_count_per_day     | 3,19,12,1,1,3,3,1,6,2,6,3,4,6,3,4,11,11,8,12,13,12,10,6,12,3,8,9,11,10,11,7,10,9,10,16,10,7,5,13,11,15,11,11,8,8,8,11,12,6,6,12,7,9,3,10,9,8,12,4,7,6,7,10,9,6,10,11,7,7,11,8,9,12,4,8,8,6,4,6,4,3,2,6,7,9,6,8,7,9,11,10,10,7,12,9,5,5,6,3
//avg_rank_per_day       | 20,4,8,22,0,54,30,5,13,10,50,5,14,26,35,4,12,34,25,8,10,7,13,10,6,21,22,14,16,24,5,15,14,13,13,11,7,30,44,26,25,7,19,6,12,16,15,9,41,3,9,51,48,10,13,15,23,31,6,17,16,17,9,38,15,12,4,10,16,91,50,11,19,15,14,18,65,24,16,17,4,9,5,4,13,0,5,8,27
