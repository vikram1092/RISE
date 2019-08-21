import UIKit
import RxSwift

enum StateState {
    case Denver
    case Houston
}

class PropertyListVC: UIViewController {
    @IBOutlet weak var propertiesCollectionView: UICollectionView!
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var coloradoButton: UIButton!
    @IBOutlet weak var texasButton: UIButton!
    @IBOutlet weak var propertiesLabel: UILabel!
    
    let disposables = CompositeDisposable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupButtons()
    }
    
    func setupViews() {
        changeToState(forState: .Denver)
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
            .map { self.changeToState(forState: .Denver) }
            .subscribe()
        
        let houstonState = texasButton.rx.tap
            .observeOn(MainScheduler.instance)
            .map { self.changeToState(forState: .Houston) }
            .subscribe()
        
        _ = disposables.insert(propertyButtons)
        _ = disposables.insert(denverState)
        _ = disposables.insert(houstonState)
    }
    
    func changeToState(forState state: StateState) {
        switch state {
        case .Denver:
            propertiesLabel.text = "Denver Properties"
            showPropertiesFor(.Denver)
        case .Houston:
            propertiesLabel.text = "Houston Properties"
            showPropertiesFor(.Houston)
        }
    }
    
    func showPropertiesFor(_ state: StateState) {
        
    }
    
    func goToDashboard() {
        let vc = DashboardVC.make()
        navigationController?.pushViewController(vc, animated: true)
    }
}
