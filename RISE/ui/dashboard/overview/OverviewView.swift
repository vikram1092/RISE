import UIKit
import Charts
import iOSDropDown

// Now called Renter Exposure
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
        bedroomDropDown.optionArray = BedroomSize.allCases.map { $0.name() }
        
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
        
        bedroomDropDown.selectedIndex = 1
        bedroomDropDown.text = BedroomSize.One.name()
        loadData()
    }
    
    func loadData() {
        
        let dateRange: [Int] = Array(0...90)
        var dataEntries: [ChartDataEntry] = []
        dateRange.forEach {
            let randomPrice: Int = (700...1500).randomElement() ?? 750
            let dataEntry = ChartDataEntry(x: Double($0),
                                           y: Double(randomPrice))
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
        setNeedsLayout()
        layoutIfNeeded()
        
        graphTitle.text = "Renter Exposure vs. Rent Decrease"
    }
}
