import UIKit

class DashboardVC: UIViewController {
    @IBOutlet weak var overviewViewContainer: UIView!
    @IBOutlet weak var acqViewContainer: UIView!
    @IBOutlet weak var conversionViewContainer: UIView!
    
    let overviewView = OverviewView.viewFromNib()
    let acqView = AcquisitionView.viewFromNib()
    let conversionView = ConversionView.viewFromNib()
    
    static func make() -> DashboardVC {
        let vc = UIStoryboard(
            name: "Main",
            bundle: nil).instantiateViewController(withIdentifier: "DashboardVC"
        ) as! DashboardVC
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        overviewViewContainer.addSubview(overviewView)
        acqViewContainer.addSubview(acqView)
        conversionViewContainer.addSubview(conversionView)
        
        let radius: CGFloat = 28
        overviewViewContainer.layer.cornerRadius = radius
        overviewViewContainer.clipsToBounds = true
        
        acqViewContainer.layer.cornerRadius = radius
        acqViewContainer.clipsToBounds = true
        
        conversionViewContainer.layer.cornerRadius = radius
        conversionViewContainer.clipsToBounds = true
    }
    
    override func viewWillLayoutSubviews() {
        overviewView.frame = overviewViewContainer.bounds
        overviewView.setNeedsLayout()
        acqView.frame = acqViewContainer.bounds
        acqView.setNeedsLayout()
        conversionView.frame = conversionViewContainer.bounds
        conversionView.setNeedsLayout()
        
        super.viewWillLayoutSubviews()
    }
}
