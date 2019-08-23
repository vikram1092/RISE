import UIKit
import iOSDropDown
import Charts

// Now called My Competition
class ConversionView: UIView, NibView {
    static var className: String = "ConversionView"
    @IBOutlet weak var priceHistoryContainer: UIView!
    @IBOutlet weak var modeDropDown: DropDown!
    @IBOutlet weak var mileageDropDown: DropDown!
    @IBOutlet weak var graphTitle: UILabel!
    @IBOutlet weak var competitorLabel: UILabel!
    
    var priceHistoryGraph: PriceHistoryGraph!
    var detailMode: DetailMode = .Interests
    var mileageMode: MileageMode = .Two
    var listing: DetailedListing?
    var durationMode: Duration = .Ninety
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func bindTo(_ listing: DetailedListing, durationMode: Duration) {
        self.listing = listing
        self.durationMode = durationMode
        
        let validMileage = MileageMode.allCases
            .filter {
                return self.getCountFor(mile: $0.rawValue) > 2
            }
        
        modeDropDown.optionArray = DetailMode.allCases.map { $0.name() }
        mileageDropDown.optionArray = validMileage
            .map { $0.name() }
        
        [modeDropDown, mileageDropDown].forEach {
            $0?.borderColor = Color.lightGray()
            $0?.borderWidth = 1
            $0?.cornerRadius = 3
            $0?.clipsToBounds = true
            $0?.arrowColor = Color.burple()
            $0?.selectedRowColor = Color.offWhite()
            $0?.checkMarkEnabled = false
            $0?.isSearchEnable = false
            $0?.setNeedsLayout()
        }
        
        modeDropDown.didSelect { [weak self] (selectedText, index ,id) in
            self?.detailMode = DetailMode.from(name: selectedText)
            self?.loadData()
        }
        mileageDropDown.didSelect { [weak self] (selectedText, index ,id) in
            self?.mileageMode = MileageMode.from(name: selectedText)
            self?.loadData()
        }
        
        if priceHistoryGraph != nil {
            priceHistoryGraph.removeFromSuperview()
        }
        priceHistoryGraph = PriceHistoryGraph.make(frame: priceHistoryContainer.bounds)
        priceHistoryContainer.addSubview(priceHistoryGraph)
        
        modeDropDown.selectedIndex = 2
        modeDropDown.text = DetailMode.Interests.name()
        
        guard let lastMile = validMileage.last else {
            return
        }
        mileageDropDown.selectedIndex = max(validMileage.count - 1, 0)
        mileageDropDown.text = lastMile.name()
        mileageMode = lastMile
        
        loadData()
    }
    
    func loadData() {
        guard let listing = listing else { return }
        let dateRange: [Int] = Array(90-durationMode.rawValue..<90)
        var propertyEntries: [ChartDataEntry] = []
        var marketEntries: [ChartDataEntry] = []
        
        let propertyPrices = getPropDetailsFor(listing)
        let marketPrices = getMarketDetailsFor(listing)
        
        dateRange.forEach {
            if (propertyPrices?.count ?? 0) > 0,
                let price = propertyPrices?[$0] {
                let dataEntry = ChartDataEntry(x: Double($0-90),
                                               y: Double(price))
                propertyEntries.append(dataEntry)
            }
            if (marketPrices?.count ?? 0) > 0,
                let price = marketPrices?[$0] {
                let dataEntry = ChartDataEntry(x: Double($0-90),
                                               y: Double(price))
                marketEntries.append(dataEntry)
            }
        }
//        dateRange.forEach {
//            if let price = propertyPrices?[$0] {
//            var yValue: Int!
//            switch detailMode {
//            case .Contacts:
//                yValue = listing.avgContactsPerDay[$0]
//            case .Exposure:
//                yValue = listing.avgExposurePerDay[$0]
//            case .Interests:
//                yValue = listing.avgInterestsPerDay[$0]
//            case .Rank:
//                yValue = listing.avgRankPerDay[$0]
//            }
//            let dataEntry = ChartDataEntry(x: Double($0-90),
//                                           y: Double(yValue))
//            propertyEntries.append(dataEntry)
//        }
        
        let marketSet = LineChartDataSet(entries: marketEntries, label: "My Competitor Average")
        let color = Color.yellow()
        marketSet.colors = [color]
        marketSet.setCircleColor(color)
        marketSet.circleRadius = 1
        marketSet.drawCircleHoleEnabled = false
        marketSet.lineWidth = 2
        marketSet.mode = .cubicBezier
        marketSet.drawValuesEnabled = false
        
        let propertySet = LineChartDataSet(entries: propertyEntries, label: "My Property")
        let propColor = Color.burple()
        propertySet.colors = [propColor]
        propertySet.setCircleColor(propColor)
        propertySet.circleRadius = 1
        propertySet.drawCircleHoleEnabled = false
        propertySet.lineWidth = 2
        propertySet.mode = .cubicBezier
        propertySet.drawValuesEnabled = false
        
        graphTitle.text = "\(detailMode.name()) for the Last \(durationMode.name().capitalized)"
        let competitors = getCountFor(mile: mileageMode.rawValue)
        let competitorString = competitors > 0 ? "\(competitors) Competitors" : ""
        competitorLabel.text = competitorString
        
        priceHistoryGraph.bindTo(dataSets: [propertySet, marketSet])
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    
    func getCountFor(mile: Int) -> Int {
        guard let listing = listing else { return 0 }
        switch mile {
        case 1:
            return listing.compCount1Mile
        case 2:
            return listing.compCount2Mile
        case 3:
            return listing.compCount3Mile
        case 4:
            return listing.compCount4Mile
        case 5:
            return listing.compCount5Mile
        default:
            return 0
        }
    }
    
    func getPropDetailsFor(_ listing: DetailedListing) -> [Int]? {
        switch detailMode {
        case .Rank:
            return listing.avgRankPerDay
        case .Exposure:
            return listing.avgExposurePerDay
        case .Interests:
            return listing.avgInterestsPerDay
        case .Contacts:
            return listing.avgContactsPerDay
        }
    }
    
    func getMarketDetailsFor(_ listing: DetailedListing) -> [Int]? {
        switch detailMode {
        case .Contacts:
            switch mileageMode {
            case .One:
                return listing.avgContacts1mi
            case .Two:
                return listing.avgContacts2mi
            case .Three:
                return listing.avgContacts3mi
            case .Four:
                return listing.avgContacts4mi
            case .Five:
                return listing.avgContacts5mi
            }
        case .Exposure:
            switch mileageMode {
            case .One:
                return listing.avgExposure1mi
            case .Two:
                return listing.avgExposure2mi
            case .Three:
                return listing.avgExposure3mi
            case .Four:
                return listing.avgExposure4mi
            case .Five:
                return listing.avgExposure5mi
            }
        case .Interests:
            switch mileageMode {
            case .One:
                return listing.avgInterests1mi
            case .Two:
                return listing.avgInterests2mi
            case .Three:
                return listing.avgInterests3mi
            case .Four:
                return listing.avgInterests4mi
            case .Five:
                return listing.avgInterests5mi
            }
        case .Rank:
            switch mileageMode {
            case .One:
                return listing.avgRank1mi
            case .Two:
                return listing.avgRank2mi
            case .Three:
                return listing.avgRank3mi
            case .Four:
                return listing.avgRank4mi
            case .Five:
                return listing.avgRank5mi
            }
        }
    }
}
