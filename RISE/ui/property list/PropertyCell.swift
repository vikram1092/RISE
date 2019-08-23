import UIKit

class PropertyCell: UICollectionViewCell, NibView {
    static var className: String = "PropertyCell"
    
    @IBOutlet weak var propNameLabel: UILabel!
    @IBOutlet weak var propImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews() {
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
    }
    
    func bindTo(listing: Listing) {
        propNameLabel.text = listing.name
        
        let imageBlock: ImageBlock = { image in
            DispatchQueue.main.async {
                self.propImageView.image = image
                self.containerView.bringSubviewToFront(self.propNameLabel)
            }
        }
        RiseApi.shared.getPhoto(id: listing.imageUrl, imageBlock: imageBlock)
    }
}
