import UIKit
import RxSwift
import iOSDropDown

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
    @IBOutlet weak var leasesLabel: UILabel!
    @IBOutlet weak var leasesImage: UIImageView!
    @IBOutlet weak var durationDropDown: DropDown!
    
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
    var rentalId: String = ""
    var listing: DetailedListing? = nil
    var durationMode: Duration = .Ninety {
        didSet {
            updateForDurationMode()
        }
    }
    
    let disposables = CompositeDisposable()
    
    static func make(rentalId: String = "p37850") -> DashboardVC {
        let vc = UIStoryboard(
            name: "Main",
            bundle: nil).instantiateViewController(withIdentifier: "DashboardVC"
        ) as! DashboardVC
        vc.rentalId = rentalId
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
        
        leasesImage.image = leasesImage.image?.withRenderingMode(.alwaysTemplate)
        
        let radius: CGFloat = 8
        [overviewViewContainer, acqViewContainer, conversionViewContainer,
         view1, view2, view3, view4].forEach {
            $0?.layer.borderColor = Color.lightGray().cgColor
            $0?.layer.borderWidth = 1
            $0?.layer.cornerRadius = radius
            $0?.clipsToBounds = true
        }
        
        setupDropdowns()
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
            case .Success(let response):
                guard let listing = RiseApi.mapRentalIdResponse(json: response)
                    else {
                        return
                }
                self.bindTo(listing)
            case .Failure(let error):
                print(error)
            }
        }
        riseApi.request(endpoint: "rental_id/\(rentalId)",
                        method: .get,
                        params: [:],
                        resultHandler: resultHandler)
    }
    
    func bindTo(_ listing: DetailedListing) {
        self.listing = listing
        DispatchQueue.main.async {
            self.durationDropDown.selectedIndex = 0
            self.durationDropDown.text = Duration.Ninety.name()
            self.updateSectionsForListing()
            self.updateForDurationMode()
            guard let listing = self.listing else { return }
            self.propertyNameLabel.text = listing.name
        }
    }
    
    func updateSectionsForListing() {
        guard let listing = listing else { return }
        overviewView.bindTo(listing)
        acqView.bindTo(listing)
        conversionView.bindTo(listing, durationMode: durationMode)
    }
    
    func updateForDurationMode() {
        guard let listing = listing else { return }
        var selectedLeaseCount = String(listing.leaseCount90Day)
        var selectedInterestCount = String(listing.interestCount90Day)
        var selectedImpressionCount = String(listing.viewCount90Day)
        var selectedContactCount = String(listing.contactCount90Day)
        var selectedRank = String(listing.avgRank90day)
        switch durationMode {
        case .Ninety:
            selectedLeaseCount = String(listing.leaseCount90Day)
            selectedImpressionCount = String(listing.viewCount90Day)
            selectedContactCount = String(listing.contactCount90Day)
            selectedInterestCount = String(listing.interestCount90Day)
            selectedRank = String(listing.avgRank90day)
        case .Sixty:
            selectedLeaseCount = String(listing.leaseCount60Day)
            selectedImpressionCount = String(listing.viewCount60Day)
            selectedContactCount = String(listing.contactCount60Day)
            selectedInterestCount = String(listing.interestCount60Day)
            selectedRank = String(listing.avgRank60day)
        case .Thirty:
            selectedLeaseCount = String(listing.leaseCount30Day)
            selectedImpressionCount = String(listing.viewCount30Day)
            selectedContactCount = String(listing.contactCount30Day)
            selectedInterestCount = String(listing.interestCount30Day)
            selectedRank = String(listing.avgRank30day)
        }
        
        leasesLabel.text = selectedLeaseCount + " Leases"
        title1.text = selectedImpressionCount
        title2.text = selectedInterestCount
        title3.text = selectedContactCount
        title4.text = selectedRank
        
        conversionView.bindTo(listing, durationMode: durationMode)
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
    }
    
    func setupDropdowns() {
        
        durationDropDown.optionArray = Duration.allCases.map { $0.name() }
        
        [durationDropDown].forEach {
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
        
        durationDropDown.didSelect { [weak self] (selectedText, index ,id) in
            self?.durationMode = Duration.from(name: selectedText)
        }
    }
}
