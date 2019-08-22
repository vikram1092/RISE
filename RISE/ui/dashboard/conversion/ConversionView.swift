import UIKit
import iOSDropDown
import Charts

// Now called Competition
class ConversionView: UIView, NibView {
    static var className: String = "ConversionView"
    @IBOutlet weak var priceHistoryContainer: UIView!
    @IBOutlet weak var modeDropDown: DropDown!
    @IBOutlet weak var mileageDropDown: DropDown!
    @IBOutlet weak var graphTitle: UILabel!
    
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
        modeDropDown.optionArray = DetailMode.allCases.map { $0.name() }
        mileageDropDown.optionArray = MileageMode.allCases.map { $0.name() }
        
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
        
        modeDropDown.selectedIndex = 1
        modeDropDown.text = DetailMode.Interests.name()
        mileageDropDown.selectedIndex = 1
        mileageDropDown.text = MileageMode.Two.name()
        loadData()
    }
    
    func loadData() {
        guard let listing = listing else { return }
        let dateRange: [Int] = Array(0...durationMode.rawValue)
        var dataEntries: [ChartDataEntry] = []
        dateRange.forEach {
            var yValue: Int!
            switch detailMode {
            case .Contacts:
                yValue = listing.avgContactsPerDay[$0]
            case .Exposure:
                yValue = listing.avgExposurePerDay[$0]
            case .Interests:
                yValue = listing.avgInterestsPerDay[$0]
            case .Rank:
                yValue = listing.avgRankPerDay[$0]
            }
            let dataEntry = ChartDataEntry(x: Double($0-durationMode.rawValue),
                                           y: Double(yValue))
            dataEntries.append(dataEntry)
        }
        
        let chartSet = LineChartDataSet(entries: dataEntries, label: detailMode.name())
        let color = Color.burple()
        chartSet.colors = [color]
        chartSet.setCircleColor(color)
        chartSet.circleRadius = 1
        chartSet.drawCircleHoleEnabled = false
        chartSet.lineWidth = 2
        chartSet.mode = .cubicBezier
        chartSet.drawValuesEnabled = false
        
        priceHistoryGraph.bindTo(dataSets: [chartSet])
        setNeedsLayout()
        layoutIfNeeded()
        
        graphTitle.text = "\(detailMode.name()) for the last \(durationMode.name())"
    }
}
