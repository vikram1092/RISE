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
    
    var avgRankPerDay: [Int]
    var avgRank1mi: [Int]? //avg_rank_per_day_1mi
    var avgRank2mi: [Int]? //avg_rank_per_day_2mi
    var avgRank3mi: [Int]? //avg_rank_per_day_3mi
    var avgRank4mi: [Int]? //avg_rank_per_day_4mi
    var avgRank5mi: [Int]? //avg_rank_per_day_5mi
    
    var avgExposurePerDay: [Int]
    var avgExposure1mi: [Int]? //view_count_per_day_1mi
    var avgExposure2mi: [Int]? //view_count_per_day_2mi
    var avgExposure3mi: [Int]? //view_count_per_day_3mi
    var avgExposure4mi: [Int]? //view_count_per_day_4mi
    var avgExposure5mi: [Int]? //view_count_per_day_5mi
    
    var avgInterestsPerDay: [Int]
    var avgInterests1mi: [Int]? //interest_count_per_day_1mi
    var avgInterests2mi: [Int]? //interest_count_per_day_2mi
    var avgInterests3mi: [Int]? //interest_count_per_day_3mi
    var avgInterests4mi: [Int]? //interest_count_per_day_4mi
    var avgInterests5mi: [Int]? //interest_count_per_day_5mi
    
    var avgContactsPerDay: [Int]
    var avgContacts1mi: [Int]? //contact_count_per_day_1mi
    var avgContacts2mi: [Int]? //contact_count_per_day_2mi
    var avgContacts3mi: [Int]? //contact_count_per_day_3mi
    var avgContacts4mi: [Int]? //contact_count_per_day_4mi
    var avgContacts5mi: [Int]? //contact_count_per_day_5mi
    
    
    var medianPrice0Bed: [Int]?
    var medianPrice1Bed: [Int]?
    var medianPrice2Bed: [Int]?
    var medianPrice3Bed: [Int]?

    var medianMetroPrice0Bed: [Int]?
    var medianMetroPrice1Bed: [Int]?
    var medianMetroPrice2Bed: [Int]?
    var medianMetroPrice3Bed: [Int]?


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
        let avgRank1miString: String = (try? map.value("avg_rank_per_day_1mi")) ?? ""
        let avgRank2miString: String = (try? map.value("avg_rank_per_day_2mi")) ?? ""
        let avgRank3miString: String = (try? map.value("avg_rank_per_day_3mi")) ?? ""
        let avgRank4miString: String = (try? map.value("avg_rank_per_day_4mi")) ?? ""
        let avgRank5miString: String = (try? map.value("avg_rank_per_day_5mi")) ?? ""
        avgRankPerDay = avgRankPerDayString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgRank1mi = avgRank1miString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgRank2mi = avgRank2miString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgRank3mi = avgRank3miString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgRank4mi = avgRank4miString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgRank5mi = avgRank5miString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        
        let avgExposurePerDayString: String = try map.value("view_count_per_day")
        let avgExposure1miString: String = (try? map.value("view_count_per_day_1mi")) ?? ""
        let avgExposure2miString: String = (try? map.value("view_count_per_day_2mi")) ?? ""
        let avgExposure3miString: String = (try? map.value("view_count_per_day_3mi")) ?? ""
        let avgExposure4miString: String = (try? map.value("view_count_per_day_4mi")) ?? ""
        let avgExposure5miString: String = (try? map.value("view_count_per_day_5mi")) ?? ""
        avgExposurePerDay = avgExposurePerDayString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgExposure1mi = avgExposure1miString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgExposure2mi = avgExposure2miString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgExposure3mi = avgExposure3miString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgExposure4mi = avgExposure4miString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgExposure5mi = avgExposure5miString.split(separator: ",")
            .map { ($0 as NSString).integerValue }

        
        let avgInterestsPerDayString: String = try map.value("interest_count_per_day")
        let avgInterest1miString: String = (try? map.value("interest_count_per_day_1mi")) ?? ""
        let avgInterest2miString: String = (try? map.value("interest_count_per_day_2mi")) ?? ""
        let avgInterest3miString: String = (try? map.value("interest_count_per_day_3mi")) ?? ""
        let avgInterest4miString: String = (try? map.value("interest_count_per_day_4mi")) ?? ""
        let avgInterest5miString: String = (try? map.value("interest_count_per_day_5mi")) ?? ""
        avgInterestsPerDay = avgInterestsPerDayString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgInterests1mi = avgInterest1miString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgInterests2mi = avgInterest2miString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgInterests3mi = avgInterest3miString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgInterests4mi = avgInterest4miString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgInterests5mi = avgInterest5miString.split(separator: ",")
            .map { ($0 as NSString).integerValue }

        let avgContactsPerDayString: String = try map.value("contact_count_per_day")
        let avgContacts1miString: String = (try? map.value("contact_count_per_day_1mi")) ?? ""
        let avgContacts2miString: String = (try? map.value("contact_count_per_day_2mi")) ?? ""
        let avgContacts3miString: String = (try? map.value("contact_count_per_day_3mi")) ?? ""
        let avgContacts4miString: String = (try? map.value("contact_count_per_day_4mi")) ?? ""
        let avgContacts5miString: String = (try? map.value("contact_count_per_day_5mi")) ?? ""
        avgContactsPerDay = avgContactsPerDayString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgContacts1mi = avgContacts1miString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgContacts2mi = avgContacts2miString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgContacts3mi = avgContacts3miString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgContacts4mi = avgContacts4miString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgContacts5mi = avgContacts5miString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        
        avgExposurePerDay = avgExposurePerDayString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgInterestsPerDay = avgInterestsPerDayString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        avgContactsPerDay = avgContactsPerDayString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        
        acquisitionData = try map.value("reverse_search_json")
        
        let medianPrice0bedString: String = (try? map.value("median_price_per_day_0_bed")) ?? ""
        let medianPrice1bedString: String = (try? map.value("median_price_per_day_1_bed")) ?? ""
        let medianPrice2bedString: String = (try? map.value("median_price_per_day_2_bed")) ?? ""
        let medianPrice3bedString: String = (try? map.value("median_price_per_day_4_bed")) ?? ""
        medianPrice0Bed = medianPrice0bedString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        medianPrice1Bed = medianPrice1bedString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        medianPrice2Bed = medianPrice2bedString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        medianPrice3Bed = medianPrice3bedString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        
        let medianMetroPrice0BedString: String = try map.value("metro_median_price_per_day_0_bed")
        let medianMetroPrice1BedString: String = try map.value("metro_median_price_per_day_1_bed")
        let medianMetroPrice2BedString: String = try map.value("metro_median_price_per_day_2_bed")
        let medianMetroPrice3BedString: String = try map.value("metro_median_price_per_day_4_bed")
        medianMetroPrice0Bed = medianMetroPrice0BedString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        medianMetroPrice1Bed = medianMetroPrice1BedString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        medianMetroPrice2Bed = medianMetroPrice2BedString.split(separator: ",")
            .map { ($0 as NSString).integerValue }
        medianMetroPrice3Bed = medianMetroPrice3BedString.split(separator: ",")
            .map { ($0 as NSString).integerValue }

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
//"avg_rank_per_day_1mi": "2,2,2,3,5,6,7,5,7,5,9,10,3,3,4,4,3,4,3,4,5,5,5,4,5,5,7,4,4,4,6,3,4,4,3,4,5,4,4,4,4,4,4,4,4,4,4,4,4,4,6,3,4,4,4,5,5,5,6,3,4,4,4,3,5,10,5,8,6,12,4,6,7,5,7,5,4,3,4,4,4,4,4,4,3,3,4,4,6,4",
//"avg_rank_per_day_2mi": "3,4,2,4,6,6,8,6,7,5,9,11,4,4,5,5,4,7,5,5,5,5,7,5,5,5,7,5,5,5,6,3,4,4,4,4,5,4,4,4,5,4,6,5,4,4,4,4,5,5,7,4,5,5,6,6,5,5,6,3,5,4,4,3,6,10,5,8,7,12,4,7,7,5,8,5,4,4,4,4,4,4,4,4,4,5,4,4,6,5",
//"avg_rank_per_day_3mi": "8,7,5,5,9,7,9,8,8,7,10,9,6,6,5,5,7,8,7,6,6,9,9,7,7,9,9,8,6,6,8,5,6,6,5,6,5,5,5,6,6,5,6,6,5,5,4,5,5,6,8,6,5,6,8,7,5,6,7,4,8,4,5,5,7,10,6,8,9,8,4,6,5,5,7,5,5,4,5,4,5,5,6,5,5,7,5,5,6,5",
//"avg_rank_per_day_4mi": "6,6,4,4,8,7,7,7,6,7,8,9,6,7,6,6,8,8,7,7,6,8,8,7,7,7,7,7,7,7,8,6,9,7,6,7,5,7,7,6,7,6,7,7,6,8,6,6,6,6,8,7,7,7,8,6,6,7,6,4,7,5,5,6,5,6,5,6,8,6,5,6,6,7,9,6,7,8,6,6,5,5,7,5,4,7,6,5,6,7",
//"avg_rank_per_day_5mi": "7,7,7,6,8,6,7,6,6,7,7,7,7,7,6,6,8,9,6,7,6,8,8,8,7,8,8,8,7,7,7,7,8,6,7,8,6,6,6,6,7,6,7,7,6,7,6,6,6,6,7,6,6,6,7,6,6,7,6,4,7,5,5,7,5,5,6,5,7,6,7,6,7,8,9,7,7,8,7,7,6,6,7,6,5,7,6,6,6,6",
//"view_count_per_day": "93,139,121,82,66,72,117,126,130,143,121,98,75,101,124,159,85,76,94,98,97,175,95,98,88,70,80,91,111,103,76,63,76,79,89,101,88,71,70,53,70,69,97,99,82,79,57,94,108,100,83,90,89,76,79,91,85,78,78,78,80,72,109,109,73,86,69,72,51,59,50,49,37,40,44,47,48,48,61,58,54,65,64,65,75,68,64,43,44,39",
//"view_count_per_day_1mi": "68,60,59,48,38,32,35,54,67,165,153,96,100,125,163,164,93,94,104,112,129,112,90,162,149,136,147,185,154,149,153,110,115,115,155,166,149,156,117,142,114,146,159,150,168,132,123,126,166,201,147,127,127,132,142,165,171,142,159,126,114,130,179,132,130,127,105,129,110,148,150,135,74,64,51,50,63,69,90,79,76,113,107,120,109,99,107,115,107,105",
//"view_count_per_day_2mi": "37,33,31,27,21,18,19,28,35,85,78,50,53,63,82,86,52,49,57,60,68,60,53,87,80,74,78,98,88,85,83,58,62,62,81,90,76,81,63,74,60,76,82,78,85,67,63,64,84,103,74,71,65,75,77,86,90,74,83,66,62,69,95,71,69,69,57,69,60,78,78,71,37,33,27,28,33,37,47,45,40,58,57,62,55,52,55,59,55,56",
//"view_count_per_day_3mi": "26,28,24,21,18,17,21,24,28,42,37,27,28,33,40,47,33,23,25,30,35,40,29,38,37,32,32,41,39,45,38,24,28,29,37,45,36,34,30,33,28,36,42,41,39,31,30,30,42,47,34,33,33,36,39,43,45,37,43,36,36,39,49,41,45,47,34,36,32,36,35,35,23,19,16,16,19,20,25,33,29,42,43,46,41,37,33,40,35,38",
//"view_count_per_day_4mi": "33,44,41,32,32,30,41,46,44,51,40,33,32,41,47,59,41,32,36,42,43,49,38,44,39,34,34,44,45,50,42,33,36,38,46,52,43,42,34,38,34,40,44,44,41,35,34,35,46,48,39,36,37,39,40,45,46,41,44,39,40,41,50,44,44,47,37,40,34,40,38,38,36,28,26,19,26,28,31,36,30,33,34,36,37,35,30,38,32,37",
//"view_count_per_day_5mi": "34,48,42,31,31,30,43,44,44,48,37,31,30,39,46,58,48,37,40,42,45,53,42,43,39,33,35,43,44,48,43,32,38,40,45,53,44,40,34,37,37,40,42,41,38,33,31,33,47,50,36,33,33,34,37,44,47,41,40,37,32,36,41,46,40,42,33,36,31,37,32,33,31,26,28,22,29,30,33,37,30,29,32,33,32,33,28,33,29,32",
//"interest_count_per_day": "20,30,17,16,11,27,32,21,32,25,23,18,23,23,36,18,15,22,16,17,36,22,23,18,17,15,21,24,21,17,19,13,15,16,19,21,9,9,6,8,15,16,16,22,10,15,17,23,21,17,22,11,19,17,18,13,14,10,17,14,15,24,19,15,15,15,7,9,9,14,13,4,6,18,11,8,15,11,15,12,8,11,16,13,7,10,9,14,11,2",
//"interest_count_per_day_1mi": "13,11,7,6,7,2,5,5,8,31,35,13,22,25,32,35,12,17,20,20,27,19,17,31,30,24,27,33,35,19,22,24,23,24,34,43,26,32,33,31,21,28,28,27,24,26,18,25,37,39,32,26,20,27,30,33,29,32,27,35,20,28,50,18,29,22,22,26,24,31,32,26,9,11,10,6,13,14,13,15,10,14,17,20,19,18,15,17,29,22",
//"interest_count_per_day_2mi": "7,6,4,3,5,1,3,2,4,15,18,7,12,13,16,20,6,8,11,13,14,11,9,17,16,13,16,17,19,10,14,12,12,12,19,23,13,16,18,15,11,15,14,15,12,13,9,13,19,21,16,15,10,15,16,17,15,17,14,17,10,15,26,10,15,12,12,14,12,17,16,13,5,5,6,5,7,8,7,9,5,7,11,11,10,9,7,9,15,11",
//"interest_count_per_day_3mi": "6,5,6,4,4,3,6,5,6,8,10,5,5,7,8,12,7,4,5,6,8,9,8,8,7,6,6,7,8,7,7,5,5,6,8,13,6,6,8,6,5,8,8,9,7,7,4,7,9,11,7,8,7,7,9,10,9,10,8,10,6,9,14,8,13,12,8,9,7,9,8,6,4,4,4,3,5,6,4,8,6,9,10,13,10,9,7,8,9,9",
//"interest_count_per_day_4mi": "7,9,11,8,9,6,13,13,11,14,9,7,7,10,10,16,9,7,9,12,10,12,10,10,9,6,8,9,9,9,11,8,7,8,10,13,9,8,8,7,7,9,8,10,10,8,6,9,11,13,8,10,7,9,9,11,8,9,9,9,7,9,13,8,10,11,8,8,8,10,9,9,7,7,6,5,7,9,8,9,7,8,8,10,8,8,6,8,7,10",
//"interest_count_per_day_5mi": "10,12,13,9,10,9,14,13,12,14,10,8,8,12,13,16,16,10,13,13,13,17,15,12,11,9,11,11,11,12,13,10,11,11,14,17,14,11,9,11,11,12,12,13,11,10,7,9,14,17,10,10,10,9,11,14,13,13,12,11,7,10,12,13,12,13,11,9,8,12,9,9,8,8,8,7,10,10,10,11,9,9,9,11,9,9,8,10,8,9",
//"contact_count_per_day": "9,11,8,7,3,15,6,4,10,10,3,4,8,6,11,6,9,8,3,6,9,5,4,6,2,2,8,9,5,6,4,8,3,3,3,8,3,2,3,2,4,4,4,9,2,3,7,4,2,2,3,3,3,4,3,2,3,2,2,2,5,3,1,1,3,1,2,1,6,1,4,2,3,1,1,3,1,2,1,1,1,3,2,4,3,1,5,1,1,2",
//"contact_count_per_day_1mi": "3,1,2,1,1,1,2,14,8,5,2,3,2,3,2,8,4,1,4,3,5,7,6,5,6,6,5,3,2,5,3,6,7,8,7,4,6,5,1,4,4,5,3,6,7,5,8,8,3,5,8,6,9,11,5,9,2,8,5,11,20,3,14,6,4,2,2,6,11,8,2,3,1,1,3,1,1,3,6,7,5,8,1,9,8,10,9,5,6,6",
//"contact_count_per_day_2mi": "1,1,1,0,1,0,1,7,4,3,1,1,1,2,1,4,2,1,2,2,2,4,3,3,3,3,2,2,2,2,2,3,4,6,3,2,3,2,0,2,2,3,1,3,3,3,4,4,1,2,4,4,6,5,3,5,1,4,2,5,10,2,7,3,2,1,1,4,5,4,1,1,0,1,1,0,2,0,0,1,3,3,3,4,0,4,4,5,4,2",
//"contact_count_per_day_3mi": "2,2,1,1,1,3,2,2,4,3,1,1,2,1,2,2,2,1,1,1,2,3,2,2,1,1,1,1,2,1,0,1,1,2,3,1,0,1,1,0,2,1,3,1,3,1,1,2,2,1,2,2,2,3,2,1,2,1,2,1,3,5,2,4,2,2,1,1,2,2,1,1,1,0,1,0,1,1,2,1,2,3,4,2,3,1,3,3,3,3",
//"contact_count_per_day_4mi": "1,3,3,3,2,2,3,2,2,3,3,1,2,3,2,4,3,2,3,2,2,3,3,2,2,1,1,2,2,2,2,1,2,2,2,4,2,1,1,1,0,2,2,3,2,3,2,2,2,3,1,2,2,2,3,3,1,2,1,2,1,2,4,2,3,2,2,1,1,3,2,2,2,2,1,1,1,1,2,2,1,1,2,3,2,2,1,3,2,3",
//"contact_count_per_day_5mi": "2,4,4,3,3,2,4,3,3,4,3,2,2,4,3,4,5,3,4,2,3,4,4,2,3,2,2,3,3,3,3,3,4,3,4,6,4,3,2,3,2,3,4,5,3,3,2,3,4,4,2,2,2,2,3,4,3,3,3,2,1,2,3,3,3,2,3,1,1,3,1,1,2,2,1,1,1,1,2,1,1,0,1,2,1,2,1,3,2,2",
//"median_price_per_day_0_bed": null,
//"median_price_per_day_1_bed": "1199,1209,1264,1194,1168,1171,1351,1338,1319,1218,1135,1216,1190.5,1157,1239,1183,1151,1325",
//"median_price_per_day_2_bed": "1600,1651,1938,1674,1565,1590,1803.5,1789,1898,1518,1452,1456,1419,1654,1657,1436,1531,1775",
//"median_price_per_day_3_bed": "2206,2108,2097.5,2183,1807,2353,1945,1955,2138,2153,2153,2153,2073,2067.5,2060,2073,1745,1919",
//"median_price_per_day_4_bed": null,
//"metro_median_price_per_day_0_bed": "1550,1595,1600,1634,1650,1650,1625,1603,1595,1595,1590,1550,1600,1600,1600,1628,1650,1600",
//"metro_median_price_per_day_1_bed": "1200,1226,1235,1229,1221,1225,1225,1222,1214,1200,1200,1195,1191,1195,1235,1225,1215,1229",
//"metro_median_price_per_day_2_bed": "1470,1489,1500,1500,1500,1499,1500,1489,1469,1455,1450,1448,1450,1480,1461,1475,1473,1465",
//"metro_median_price_per_day_3_bed": "1550,1550,1595,1600,1600,1600,1600,1575,1550,1550,1550,1550,1550,1580,1600,1600,1600,1600",
//"metro_median_price_per_day_4_bed": "1800,1800,1850,1895,1900,1900,1900,1895,1850,1800,1800,1800,1825,1825,1825,1870,1900,1900"
//}
