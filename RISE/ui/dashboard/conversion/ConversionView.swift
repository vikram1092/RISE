import UIKit
import iOSDropDown
import Charts

class ConversionView: UIView, NibView {
    static var className: String = "ConversionView"
    @IBOutlet weak var priceHistoryContainer: UIView!
    @IBOutlet weak var modeDropDown: DropDown!
    @IBOutlet weak var mileageDropDown: DropDown!
    
    var priceHistoryGraph: PriceHistoryGraph!
    var detailMode: DetailMode = .Interests
    var mileageMode: MileageMode = .Two
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func bindTo() {
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
        let dateRange: [Int] = Array(0...90)
        var dataEntries: [ChartDataEntry] = []
        dateRange.forEach {
            let randomPrice: Int = (700...1500).randomElement() ?? 750
            let dataEntry = ChartDataEntry(x: Double($0), y: Double(randomPrice))
            dataEntries.append(dataEntry)
        }
        
        let chartSet = LineChartDataSet(entries: dataEntries, label: "Prices")
        chartSet.colors = [Color.burple()]
        chartSet.setCircleColor(Color.burple())
        chartSet.circleRadius = 1
        chartSet.drawCircleHoleEnabled = false
        chartSet.lineWidth = 2
        chartSet.mode = .cubicBezier
        chartSet.drawValuesEnabled = false
        
        priceHistoryGraph.bindTo(dataSets: [chartSet])
        setNeedsLayout()
        layoutIfNeeded()
    }
}
