import UIKit
import RxSwift

enum StateState {
    case Colorado
    case Texas
}

enum Tab {
    case First
    case Second
    case Third
}

class PropertyListVC: UIViewController {
    @IBOutlet weak var coloradoButton: UIButton!
    @IBOutlet weak var texasButton: UIButton!
    @IBOutlet weak var propertiesLabel: UILabel!
    @IBOutlet weak var propertyCollectionView: UICollectionView!
    @IBOutlet weak var propertiesView: UIView!
    @IBOutlet weak var mapImageView: UIImageView!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var selectView1: UIView!
    @IBOutlet weak var selectView2: UIView!
    @IBOutlet weak var selectView3: UIView!
    @IBOutlet weak var bigView1: UIView!
    @IBOutlet weak var bigView2: UIView!
    @IBOutlet weak var bigView3: UIView!
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
    
    var state: StateState = .Colorado {
        didSet {
            changeToState(forState: self.state)
        }
    }
    var coloradoProperties: [Listing] = sampleColoradoData
    var texasProperties: [Listing] = sampleTexasData

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupButtons()
    }
    
    func setupViews() {
        propertyCollectionView.dataSource = self
        propertyCollectionView.delegate = self
        propertyCollectionView.register(PropertyCell.nib(),
                                        forCellWithReuseIdentifier: PropertyCell.className)
        
        state = .Colorado
        
        let radius: CGFloat = 8
        propertiesView.layer.cornerRadius = radius
        propertiesView.clipsToBounds = true
        propertiesView.layer.borderColor = Color.lightGray().cgColor
        propertiesView.layer.borderWidth = 1
//        view1Button.layer.cornerRadius = 4
//        view2Button.layer.cornerRadius = 4
//        view3Button.layer.cornerRadius = 4
        
        image1.image = image1.image?.withRenderingMode(.alwaysTemplate)
        image2.image = image2.image?.withRenderingMode(.alwaysTemplate)
        image3.image = image3.image?.withRenderingMode(.alwaysTemplate)
        changeToTab(tab: .First)
    }
    
    func setupButtons() {
        let denverState = coloradoButton.rx.tap
            .observeOn(MainScheduler.instance)
            .map { self.state = .Colorado }
            .subscribe()
        
        let houstonState = texasButton.rx.tap
            .observeOn(MainScheduler.instance)
            .map { self.state = .Texas }
            .subscribe()
        
        let firstButton = button1.rx.tap
            .observeOn(MainScheduler.instance)
            .map { self.changeToTab(tab: .First) }
            .subscribe()
        
        let secondButton = button2.rx.tap
            .observeOn(MainScheduler.instance)
            .map { self.changeToTab(tab: .Second) }
            .subscribe()
        
        let thirdButton = button3.rx.tap
            .observeOn(MainScheduler.instance)
            .map { self.changeToTab(tab: .Third) }
            .subscribe()
        
        _ = disposables.insert(denverState)
        _ = disposables.insert(houstonState)
        _ = disposables.insert(firstButton)
        _ = disposables.insert(secondButton)
        _ = disposables.insert(thirdButton)
    }
    
    func changeToTab(tab: Tab) {
        var selectedImageView: UIImageView = image1
        var selectedSelectView: UIView = selectView1
        var selectedBigView: UIView = bigView1
        
        switch tab {
        case .First:
            ()
        case .Second:
            selectedImageView = image2
            selectedSelectView = selectView2
            selectedBigView = bigView2
        case .Third:
            selectedImageView = image3
            selectedSelectView = selectView3
            selectedBigView = bigView3
        }
        
        [image1, image2, image3].forEach({
            if $0 == selectedImageView {
                $0?.backgroundColor = Color.n0()
                $0?.tintColor = Color.burple()
            }
            else {
                $0?.backgroundColor = Color.clear()
                $0?.tintColor = Color.slate()
            }
        })
        
        [selectView1, selectView2, selectView3].forEach({
            if $0 == selectedSelectView {
                $0?.isHidden = false
            }
            else {
                $0?.isHidden = true
            }
        })
        
        [bigView1, bigView2, bigView3].forEach({
            if $0 == selectedBigView {
                $0?.isHidden = false
            }
            else {
                $0?.isHidden = true
            }
        })
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
        propertyCollectionView.reloadData()
    }
    
    func goToDashboard() {
        let vc = DashboardVC.make()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PropertyListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch state {
        case .Colorado:
            return coloradoProperties.count
        case .Texas:
            return texasProperties.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PropertyCell.className,
            for: indexPath) as? PropertyCell else {
            return UICollectionViewCell()
        }
        switch state {
        case .Colorado:
            cell.bindTo(listing: coloradoProperties[indexPath.item])
        case .Texas:
            cell.bindTo(listing: texasProperties[indexPath.item])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch state {
        case .Colorado:
            goToDashboard()
        case .Texas:
            goToDashboard()
        }
    }
}



let sampleColoradoData: [Listing] = try! [
    Listing(JSON: ["name":"Avalon", "imageUrl":""]),
    Listing(JSON: ["name":"Eaves", "imageUrl":""]),
    Listing(JSON: ["name":"Parkland", "imageUrl":""]),
    Listing(JSON: ["name":"Haven", "imageUrl":""]),
]

let sampleTexasData: [Listing] = try! [
    Listing(JSON: ["name":"The Ranch", "imageUrl":""]),
    Listing(JSON: ["name":"Houstoner", "imageUrl":""]),
    Listing(JSON: ["name":"The Barn Lofts", "imageUrl":""]),
]
