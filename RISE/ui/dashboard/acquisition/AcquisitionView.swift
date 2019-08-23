import UIKit
import iOSDropDown
import Charts

// Now called My Market 
class AcquisitionView: UIView, NibView {
    static var className: String = "AcquisitionView"
    @IBOutlet weak var priceHistoryContainer: UIView!
    @IBOutlet weak var bedroomDropDown: DropDown!
    @IBOutlet weak var graphTitle: UILabel!
    
    var listing: DetailedListing?
    var priceHistoryGraph: PriceHistoryGraph!
    var bedroomMode: BedroomSize = .One
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func bindTo(_ listing: DetailedListing, duration: Duration) {
        self.listing = listing
        let validBedroomArray = BedroomSize.allCases
            .filter { option in
                return listing.acquisitionData.contains(where: { set -> Bool in
                    return option.rawValue == set.bed
                })}
        bedroomDropDown.optionArray = validBedroomArray
            .map { $0.name() }
        
        [bedroomDropDown].forEach {
            $0?.borderColor = Color.lightGray()
            $0?.borderWidth = 1
            $0?.cornerRadius = 3
            $0?.clipsToBounds = true
            $0?.arrowColor = Color.blue()
            $0?.selectedRowColor = Color.offWhite()
            $0?.checkMarkEnabled = false
            $0?.isSearchEnable = false
            $0?.setNeedsLayout()
        }
        
        bedroomDropDown.didSelect { [weak self] (selectedText, index ,id) in
            self?.bedroomMode = BedroomSize.from(name: selectedText)
            self?.loadData()
        }
        
        if priceHistoryGraph != nil {
            priceHistoryGraph.removeFromSuperview()
        }
        priceHistoryGraph = PriceHistoryGraph.make(frame: priceHistoryContainer.bounds)
        priceHistoryContainer.addSubview(priceHistoryGraph)
        
        guard let firstBedroom = validBedroomArray.first else {
            loadData()
            return
        }
        bedroomMode = firstBedroom
        bedroomDropDown.selectedIndex = 1
        bedroomDropDown.text = firstBedroom.name()
        loadData()
    }
    
    func loadData() {
        guard let listing = listing else { return }
        let dateRange: [Int] = Array(0..<18)
        var propertyEntries: [ChartDataEntry] = []
        var marketEntries: [ChartDataEntry] = []
        
        let propertyPrices = getPricesFor(listing, beds: bedroomMode)
        let marketPrices = getMarketPricesFor(listing, beds: bedroomMode)
        
        dateRange.forEach {
            if let price = propertyPrices?[$0] {
                let dataEntry = ChartDataEntry(x: Double($0-17),
                                               y: Double(price))
                propertyEntries.append(dataEntry)
            }
            if let price = marketPrices?[$0] {
                let dataEntry = ChartDataEntry(x: Double($0-17),
                                               y: Double(price))
                marketEntries.append(dataEntry)
            }
        }
        
        let marketSet = LineChartDataSet(entries: marketEntries, label: "Neighborhood Price")
        let color = Color.blue()
        marketSet.colors = [color]
        marketSet.setCircleColor(color)
        marketSet.circleRadius = 1
        marketSet.drawCircleHoleEnabled = false
        marketSet.lineWidth = 2
        marketSet.mode = .cubicBezier
        marketSet.drawValuesEnabled = false
        
        let propertySet = LineChartDataSet(entries: propertyEntries, label: "Property Price")
        let propColor = Color.burple()
        propertySet.colors = [propColor]
        propertySet.setCircleColor(propColor)
        propertySet.circleRadius = 1
        propertySet.drawCircleHoleEnabled = false
        propertySet.lineWidth = 2
        propertySet.mode = .cubicBezier
        propertySet.drawValuesEnabled = false
        
        priceHistoryGraph.bindTo(dataSets: [propertySet, marketSet])
        setNeedsLayout()
        layoutIfNeeded()
        
        graphTitle.text = "Property Price vs Avg. Neighborhood Price"
    }
    
    func getPricesFor(_ listing: DetailedListing, beds: BedroomSize) -> [Int]? {
        switch beds {
        case .Zero:
            return listing.medianPrice0Bed
        case .One:
            return listing.medianPrice1Bed
        case .Two:
            return listing.medianPrice2Bed
        case .Three:
            return listing.medianPrice3Bed
        }
    }
    
    func getMarketPricesFor(_ listing: DetailedListing, beds: BedroomSize) -> [Int]? {
        switch beds {
        case .Zero:
            return listing.medianMetroPrice0Bed
        case .One:
            return listing.medianMetroPrice1Bed
        case .Two:
            return listing.medianMetroPrice2Bed
        case .Three:
            return listing.medianMetroPrice3Bed
        }
    }
}
