import UIKit

class ConversionView: UIView, NibView {
    static var className: String = "ConversionView"
    @IBOutlet weak var priceHistoryContainer: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func bindTo() {
        let priceHistoryGraph = PriceHistoryGraph.make(frame: priceHistoryContainer.bounds)
        
        priceHistoryContainer.addSubview(priceHistoryGraph)
        setNeedsLayout()
        layoutIfNeeded()
        priceHistoryGraph.bindTo()
    }
}
