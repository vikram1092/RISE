import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        hidesBarsOnSwipe = true
        navigationBar.prefersLargeTitles = true
    }
}
