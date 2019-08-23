import UIKit
import Charts
import iOSDropDown

// Now called My Renter Reach
class OverviewView: UIView, NibView {
    static var className: String = "OverviewView"
    @IBOutlet weak var priceHistoryContainer: UIView!
    @IBOutlet weak var bedroomDropDown: DropDown!
    @IBOutlet weak var graphTitle: UILabel!
    
    var priceHistoryGraph: PriceHistoryGraph!
    var bedroomMode: BedroomSize = .One
    var listing: DetailedListing?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func bindTo(_ listing: DetailedListing) {
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
        bedroomDropDown.selectedIndex = 0
        bedroomDropDown.text = firstBedroom.name()
        loadData()
    }
    
    func loadData() {
        
        let optionalData = listing?.acquisitionData
            .first(where: { $0.bed == bedroomMode.rawValue })
        guard let data = optionalData else { return }
        
        let price = data.currentPrice
        let adjustedExposures = data.exposures.sorted { a, b -> Bool in
            return (a.key as NSString).integerValue < (b.key as NSString).integerValue
        }
        .filter {
            let keyValue = ($0.key as NSString).integerValue
            let threshold = 500
            let range = price-threshold...price+threshold
            return range.contains(keyValue)
        }
        
        var dataEntries: [ChartDataEntry] = []
        adjustedExposures.forEach { key, value in
            let dataEntry = ChartDataEntry(x: Double((key as NSString).integerValue),
                                           y: Double(value))
            dataEntries.append(dataEntry)
        }
        
        let chartSet = LineChartDataSet(entries: dataEntries, label: "Exposure")
        let color = Color.yellow()
        chartSet.colors = [color]
        chartSet.setCircleColor(color)
        chartSet.circleRadius = 1
        chartSet.drawCircleHoleEnabled = false
        chartSet.lineWidth = 2
        chartSet.mode = .cubicBezier
        chartSet.drawValuesEnabled = false
        
        priceHistoryGraph.bindTo(dataSets: [chartSet])
        priceHistoryGraph.drawLimitLineAt(value: Double(price))
        setNeedsLayout()
        layoutIfNeeded()
        
        graphTitle.text = "Renter Exposure vs. Rent Increase"
    }
}
