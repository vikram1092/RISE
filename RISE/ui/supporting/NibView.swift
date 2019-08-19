import Foundation
import MapKit

/**
 Convenience protocol with an extension for common nib functions and properties, given
 the convention that the nibName and reuseId are the same as the className.
 */
protocol NibView {
    static var className: String { get }
}

extension NibView {
    static var reuseId: String { return className }
}

extension NibView where Self: UIView {
    
    static func nib() -> UINib {
        return UINib(nibName: className, bundle: nil)
    }
    
    static func viewFromNib() -> Self {
        let views = Bundle.main.loadNibNamed(className, owner: nil, options: nil)
        let view = views?.first as! Self
        return view
    }
}

extension NibView where Self: UITableViewCell {
    static func registerForTableView(_ tableView: UITableView) {
        tableView.register(nib(), forCellReuseIdentifier: reuseId)
    }
}

extension NibView where Self: UITableViewHeaderFooterView {
    static func registerForTableView(_ tableView: UITableView) {
        tableView.register(nib(), forHeaderFooterViewReuseIdentifier: reuseId)
    }
}

extension NibView where Self: UICollectionViewCell {
    static func registerForCollectionView(_ collectionView: UICollectionView) {
        collectionView.register(nib(), forCellWithReuseIdentifier: reuseId)
    }
}

extension NibView where Self: MKAnnotationView {
    static func dequeueFromMapView(_ mapView: MKMapView) -> Self? {
        return mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? Self
    }
}
