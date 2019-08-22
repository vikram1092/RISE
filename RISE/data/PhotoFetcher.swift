import Foundation
import Cloudinary
import Kingfisher

typealias ImageCompletion = (ImageResult) -> Void

enum ImageResult {
    case success(UIImage, cached: Bool)
    case failure(NSError)
}

private let cloudinary = CLCloudinary(cloudName: "apartmentlist")

/**
 Combination of Extension and TransformSize
 */
enum ImageType {
    case amenitySmall
    case amenityMedium
    case floorplanMedium
    case listingMedium
    case location
    case metro
    case category
    case latest
    
    fileprivate var value: (ext: Extension, size: TransformSize) {
        switch self {
        case .amenitySmall:      return (.PNG, .Tiny)
        case .amenityMedium:     return (.PNG, .Amenity)
        case .floorplanMedium:   return (.JPG, .Mid)
        case .listingMedium:     return (.JPG, .Mid)
        case .location:          return (.JPG, .Location)
        case .category:          return (.PNG, .Category)
        // TODO: Update Cloudinary so this supports .JPG
        case .metro:             return (.PNG, .Metro)
        case .latest:            return (.JPG, .Latest)
        }
    }
    
    fileprivate var ext: Extension {
        return value.ext
    }
    
    fileprivate var size: TransformSize {
        return value.size
    }
}

private enum Extension: String {
    case JPG = "jpg"
    case PNG = "png"
}

enum TransformSize: String {
    case Tiny = "square_16_x2"
    case Amenity = "square_32_x2"
    case Location = "mobile_location_picker_2x"
    case Metro = "mobile_metro_picker"
    case Category = "mobile_app_category_icon_2x"
    case Mid = "mobile_app_slideshow_retina"
    case Full = "fullsize"
    case Latest = "mobile_app_latest"
}

final class PhotoFetcher {
    static let shared = PhotoFetcher()
    
    /// Cache of recent images, used to display "random" images in `CategoriesToMatchesAnimator`.
    fileprivate var recentListingImages = Set<UIImage>()
    
    /// Keeps a reference to RetrieveImageTasks for each UIImageView,
    /// so we can cancel them as needed.
    fileprivate var imageViewTasks = [UIImageView: DownloadTask]()
    
    init() {
        // Setup Kingfisher
        let cache = KingfisherManager.shared.cache
        // 100 MB (in bytes)
        cache.maxDiskCacheSize = UInt(100 * 1024 * 1024)
        cache.clearDiskCache()
        cache.clearMemoryCache()
    }
    
    /**
     Async request a cloudinary photo ID. May be cached.
     */
    func fetch(withCloudinaryId id: String,
               imageView: UIImageView? = nil,
               imageType: ImageType,
               completion: @escaping ImageCompletion)
    {
        // Cancel any existing requests, just in case.
        if let imageView = imageView {
            cancelFetch(forImageView: imageView)
        }
        
        let url = urlForCloudinaryId(id, imageType: imageType)
        
        let completionWrap: CompletionHandler = { image, error, cacheType, imageURL in
            if let error = error {
                completion(.failure(error))
            } else if let image = image {
                let cached: Bool = (cacheType != .none)
                completion(.success(image, cached: cached))
            } else {
                let msg = "unknown image fetching error"
                assert(false, msg)
                let error = NSError(domain: "", code: 5, userInfo: [:])
                completion(.failure(error))
            }
            
            // Update cache of recent images
            if let image = image, imageType == .listingMedium {
                self.addRandomListingImage(image)
            }
            
            // Remove tasks from tracking
            if let imageView = imageView {
                self.imageViewTasks[imageView] = nil
            }
        }
        
        let retrieveImageTask = KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil, completionHandler: completionWrap)
        
        if let imageView = imageView {
            if imageViewTasks[imageView] != nil {
                assert(false, "Task already exists for imageView. " +
                    "Call cancelFetch before issuing another fetch on the same imageView.")
            }
            imageViewTasks[imageView] = retrieveImageTask
        }
    }
    
    func cancelFetch(forImageView imageView: UIImageView) {
        guard let task = imageViewTasks[imageView] else {
            return
        }
        
        task.cancel()
        imageViewTasks[imageView] = nil
    }
    
    // MARK: Helpers
    fileprivate func urlForCloudinaryId(_ id: String,
                                        imageType: ImageType) -> URL
    {
        let transform = CLTransformation(size: imageType.size)
        return URL(string: cloudinary.url("\(id).\(imageType.ext.rawValue)",
            options: ["transformation": transform]))!
    }
    
    fileprivate func addRandomListingImage(_ image: UIImage) {
        // Persist the last image in recentListingImages, and treat these as
        // random images used for CategoriesToMatchesAnimator.
        DispatchQueue.main.async {
            self.recentListingImages.insert(image)
        }
    }
}

extension CLCloudinary {
    convenience init(cloudName: String) {
        self.init()
        self.config().setValue(cloudName, forKey: "cloud_name")
    }
}

extension CLTransformation {
    convenience init(size: TransformSize) {
        self.init()
        self.named = size.rawValue
    }
}

//// MARK: Prefetch Photos
//extension PhotoFetcher {
//    /**
//     Prefetches a specified number of photos for the provided listing and caches them for future use.
//     */
//    func prefetch(forListing listing: Listing, maxCount: Int = 1)
//    {
//        let max = maxCount.clamp(0, listing.photos.count - 1)
//
//        let ids = listing.photos[0..<max].map { $0.id }
//
//        prefetch(withCloudinaryIds: ids, imageType: .listingMedium)
//    }
//
//    /**
//     Prefetches cloudinary images and caches them for future use.
//     */
//    func prefetch(withCloudinaryIds ids: [String], imageType: ImageType)
//    {
//        let urls = ids.map { self.urlForCloudinaryId($0, imageType: imageType) }
//        let completion: PrefetcherCompletionHandler = {
//            skippedResources, failedResources, completedResources in
//
//            for resource in completedResources {
//
//                // Update cache of recent images
//                if let image = KingfisherManager.shared.cache
//                    .retrieveImageInMemoryCache(forKey: resource.cacheKey), imageType == .listingMedium
//                {
//                    self.addRandomListingImage(image)
//                }
//            }
//        }
//
//        ImagePrefetcher(urls: urls, completionHandler: completion).start()
//    }
//}
