import UIKit
import RxSwift

enum DashboardState {
    case Performance
    case Geography
    case Competition
}

class DashboardVC: UIViewController {
    @IBOutlet weak var propertyNameLabel: UILabel!
    @IBOutlet weak var overviewViewContainer: UIView!
    @IBOutlet weak var acqViewContainer: UIView!
    @IBOutlet weak var conversionViewContainer: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var performanceButton: UIButton!
    @IBOutlet weak var geographyButton: UIButton!
    @IBOutlet weak var competitionButton: UIButton!
    @IBOutlet weak var performanceUnderscore: UIView!
    @IBOutlet weak var geographyUnderscore: UIView!
    @IBOutlet weak var competitionUnderscore: UIView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var title3: UILabel!
    @IBOutlet weak var title4: UILabel!
    @IBOutlet weak var subtitle1: UILabel!
    @IBOutlet weak var subtitle2: UILabel!
    @IBOutlet weak var subtitle3: UILabel!
    @IBOutlet weak var subtitle4: UILabel!
    
    let overviewView = OverviewView.viewFromNib()
    let acqView = AcquisitionView.viewFromNib()
    let conversionView = ConversionView.viewFromNib()
    let riseApi = RiseApi.shared
    
    let disposables = CompositeDisposable()
    
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
        setupButtons()
        hitApiRequests()
    }
    
    func setupViews() {
        
        overviewViewContainer.addSubview(overviewView)
        acqViewContainer.addSubview(acqView)
        conversionViewContainer.addSubview(conversionView)
        
        let backImage = UIImage(named: "back")?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(backImage, for: .normal)
        backButton.tintColor = Color.slate()
        
        let radius: CGFloat = 8
        [overviewViewContainer, acqViewContainer, conversionViewContainer,
         view1, view2, view3, view4].forEach {
            $0?.layer.borderColor = Color.lightGray().cgColor
            $0?.layer.borderWidth = 1
            $0?.layer.cornerRadius = radius
            $0?.clipsToBounds = true
        }
        
        changeToState(state: .Competition)
    }
    
    func setupButtons() {
        
        let back = backButton.rx.tap
            .observeOn(MainScheduler.instance)
            .map { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            .subscribe()
        
        let performance = performanceButton.rx.tap
            .observeOn(MainScheduler.instance)
            .map { [weak self] _ in
                self?.changeToState(state: .Performance)
            }
            .subscribe()
        
        let acquisition = geographyButton.rx.tap
            .observeOn(MainScheduler.instance)
            .map { [weak self] _ in
                self?.changeToState(state: .Geography)
            }
            .subscribe()
        
        let conversion = competitionButton.rx.tap
            .observeOn(MainScheduler.instance)
            .map { [weak self] _ in
                self?.changeToState(state: .Competition)
            }
            .subscribe()
        
        _ = disposables.insert(back)
        _ = disposables.insert(performance)
        _ = disposables.insert(acquisition)
        _ = disposables.insert(conversion)
    }
    
    func hitApiRequests() {
        
        let resultHandler: ResultBlock = { result in
            switch result {
            case .Loading:
                ()
            case .Success(let testResponse):
                print(testResponse)
            case .Failure(let error):
                print(error)
            }
        }
        riseApi.testGet(endpoint: "ping",
                        method: .get,
                        params: [:],
                        resultHandler: resultHandler)
    }
    
    func changeToState(state: DashboardState) {
        
        switch state {
        case .Performance:
            view.bringSubviewToFront(overviewViewContainer)
            overviewViewContainer.isHidden = false
            acqViewContainer.isHidden = true
            conversionViewContainer.isHidden = true
        case .Geography:
            view.bringSubviewToFront(acqViewContainer)
            overviewViewContainer.isHidden = true
            acqViewContainer.isHidden = false
            conversionViewContainer.isHidden = true
        case .Competition:
            view.bringSubviewToFront(conversionViewContainer)
            overviewViewContainer.isHidden = true
            acqViewContainer.isHidden = true
            conversionViewContainer.isHidden = false
        }
        
        underscoreFor(state: state)
    }
    
    func underscoreFor(state: DashboardState) {
        performanceUnderscore.isHidden = !(state == .Performance)
        geographyUnderscore.isHidden = !(state == .Geography)
        competitionUnderscore.isHidden = !(state == .Competition)
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        overviewView.bindTo()
        acqView.bindTo()
        conversionView.bindTo()
    }
}
