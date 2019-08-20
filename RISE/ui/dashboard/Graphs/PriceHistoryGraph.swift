import UIKit
import Charts

class PriceHistoryGraph: UIView, NibView {
    static var className: String = "PriceHistoryGraph"
    @IBOutlet weak var chartView: LineChartView!
    
    static func make(frame: CGRect) -> PriceHistoryGraph {
        let graphView = PriceHistoryGraph.viewFromNib()
        graphView.frame = frame
        return graphView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindTo() {
        let dateRange: [Int] = Array(0...30)
        var dataEntries: [ChartDataEntry] = []
        dateRange.forEach {
            let randomPrice: Int = (700...1500).randomElement() ?? 750
            let dataEntry = ChartDataEntry(x: Double($0), y: Double(randomPrice))
            dataEntries.append(dataEntry)
        }
        
        let chartSet = LineChartDataSet(entries: dataEntries, label: "Prices")
        chartSet.colors = [Color.slate()]
        chartSet.setCircleColor(Color.blue())
        chartSet.circleRadius = 2
        chartSet.drawCircleHoleEnabled = false
        chartSet.lineWidth = 2
        
        let data = LineChartData(dataSet: chartSet)
        data.setValueTextColor(.white)
        data.setValueFont(.systemFont(ofSize: 9, weight: .medium))
        
        chartView.data = data
        chartView.backgroundColor = .clear
        chartView.gridBackgroundColor = .clear
        chartView.drawGridBackgroundEnabled = false
        chartView.drawBordersEnabled = false
        
        chartView.rightAxis.enabled = false
        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.drawGridLinesEnabled = false
        leftAxis.drawAxisLineEnabled = true
        leftAxis.labelTextColor = .white
        leftAxis.labelFont = .systemFont(ofSize: 14, weight: .medium)
        
        let xAxis = chartView.xAxis
        xAxis.removeAllLimitLines()
        xAxis.drawGridLinesEnabled = false
        xAxis.drawAxisLineEnabled = true
        xAxis.labelTextColor = .white
        xAxis.labelFont = .systemFont(ofSize: 14, weight: .medium)
        
        let legend = chartView.legend
        legend.textColor = .white
        legend.font = .systemFont(ofSize: 14, weight: .medium)
        
        chartView.setNeedsLayout()
        chartView.setNeedsDisplay()
        layoutIfNeeded()
    }
}
