import UIKit
import RxSwift

enum StateState {
    case Colorado
    case Texas
}

class PropertyListVC: UIViewController {
    @IBOutlet weak var propertiesCollectionView: UICollectionView!
    @IBOutlet weak var coloradoButton: UIButton!
    @IBOutlet weak var texasButton: UIButton!
    @IBOutlet weak var propertiesLabel: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var property1Label: UILabel!
    @IBOutlet weak var property2Label: UILabel!
    @IBOutlet weak var property3Label: UILabel!
    @IBOutlet weak var city1Label: UILabel!
    @IBOutlet weak var city2Label: UILabel!
    @IBOutlet weak var city3Label: UILabel!
    @IBOutlet weak var units1Label: UILabel!
    @IBOutlet weak var units2Label: UILabel!
    @IBOutlet weak var units3Label: UILabel!
    @IBOutlet weak var view1Button: UIButton!
    @IBOutlet weak var view2Button: UIButton!
    @IBOutlet weak var view3Button: UIButton!
    
    let disposables = CompositeDisposable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupButtons()
    }
    
    func setupViews() {
        changeToState(forState: .Colorado)
        view1Button.layer.cornerRadius = 4
        view2Button.layer.cornerRadius = 4
        view3Button.layer.cornerRadius = 4
    }
    
    func setupButtons() {
        let first = button1.rx.tap
        let second = button2.rx.tap
        let third = button3.rx.tap
        
        let propertyButtons = Observable.combineLatest(first, second, third)
            .observeOn(MainScheduler.instance)
            .map { [weak self] _ in
                self?.goToDashboard()
            }
            .subscribe()
        
        let denverState = coloradoButton.rx.tap
            .observeOn(MainScheduler.instance)
            .map { self.changeToState(forState: .Colorado) }
            .subscribe()
        
        let houstonState = texasButton.rx.tap
            .observeOn(MainScheduler.instance)
            .map { self.changeToState(forState: .Texas) }
            .subscribe()
        
        _ = disposables.insert(propertyButtons)
        _ = disposables.insert(denverState)
        _ = disposables.insert(houstonState)
    }
    
    func changeToState(forState state: StateState) {
        switch state {
        case .Colorado:
            propertiesLabel.text = "Colorado Properties"
            showPropertiesFor(.Colorado)
        case .Texas:
            propertiesLabel.text = "Texas Properties"
            showPropertiesFor(.Texas)
        }
    }
    
    func showPropertiesFor(_ state: StateState) {
        
    }
    
    func goToDashboard() {
        let vc = DashboardVC.make()
        navigationController?.pushViewController(vc, animated: true)
    }
}
