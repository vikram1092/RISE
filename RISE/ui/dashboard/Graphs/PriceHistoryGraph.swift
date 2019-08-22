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
    
    func bindTo(dataSets: [ChartDataSet]) {
        
        let data = LineChartData(dataSets: dataSets)
        data.setValueTextColor(Color.lightGray())
        data.setValueFont(.systemFont(ofSize: 9, weight: .medium))
        
        chartView.data = data
        chartView.backgroundColor = .clear
        chartView.gridBackgroundColor = .clear
        chartView.drawGridBackgroundEnabled = false
        chartView.drawBordersEnabled = false
        
        chartView.rightAxis.enabled = false
        let linesWidth: CGFloat = 4
        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.drawAxisLineEnabled = true
        leftAxis.labelTextColor = Color.lightGray()
        leftAxis.labelFont = .systemFont(ofSize: 14, weight: .medium)
        leftAxis.gridColor = Color.offWhite()
        leftAxis.gridLineWidth = linesWidth
        leftAxis.gridLineDashPhase = linesWidth
        leftAxis.gridLineDashLengths = [linesWidth, linesWidth]
        leftAxis.axisLineWidth = 0
        leftAxis.axisLineDashPhase = linesWidth
        leftAxis.axisLineDashLengths = [linesWidth, linesWidth]
        leftAxis.axisLineColor = Color.offWhite()
        
        let xAxis = chartView.xAxis
        xAxis.removeAllLimitLines()
        xAxis.drawGridLinesEnabled = false
        xAxis.drawAxisLineEnabled = true
        xAxis.labelPosition = XAxis.LabelPosition.bottom
        xAxis.labelTextColor = Color.lightGray()
        xAxis.labelFont = .systemFont(ofSize: 14, weight: .medium)
        xAxis.axisLineWidth = linesWidth
        xAxis.axisLineDashPhase = linesWidth
        xAxis.axisLineDashLengths = [linesWidth, linesWidth]
        xAxis.axisLineColor = Color.offWhite()
        
        let legend = chartView.legend
        legend.textColor = Color.lightGray()
        legend.font = .systemFont(ofSize: 14, weight: .medium)
        
        chartView.setNeedsLayout()
        chartView.setNeedsDisplay()
        layoutIfNeeded()
    }
}
