import Foundation
import Alamofire

import RxAlamofire
import RxSwift

public typealias ResultBlock = (AsyncResult<JSONDict>) -> Void
public typealias EmptyBlock = () -> Void
public typealias ErrorBlock = (NSError) -> Void
public typealias JSONDict = [String: AnyObject]
public typealias JSONDictBlock = (JSONDict) -> Void
public typealias ImageBlock = (UIImage) -> Void

struct APIRequest {
    
    var path: String
    var method: HTTPMethod
    var encoding: Alamofire.ParameterEncoding
    var params: JSONDict?
    /// Optional Auth token to use for authentication instead of the Instance Manager auth token.
    var authToken: String?
    
    init(path: String,
         method: HTTPMethod,
         params: JSONDict? = nil,
         encoding: Alamofire.ParameterEncoding = URLEncoding.default,
         authToken: String? = nil) {
        
        self.path = path
        self.method = method
        self.params = params
        self.encoding = encoding
        self.authToken = authToken
    }
}

enum ApiBaseURL : String {
    case Base = "https://alx-rise.herokuapp.com"
}

final class APISessionManager {
    let apiKey = "m93TumTsg9cG36cazYy5Nn7j2smgQxRx"
    let headers: HTTPHeaders = ["X-API-Secret":"m93TumTsg9cG36cazYy5Nn7j2smgQxRx"]
    let baseURL : String = ApiBaseURL.Base.rawValue
    
    let cloudinaryUrl = "https://res.cloudinary.com/apartmentlist/image/upload/t_fullsize/"
    
    let session = URLSession.init(configuration: .default)
    var imageCache = [String: UIImage]()
    
    var urlString : String {
        return "\(baseURL)/"
    }
    
    func dataRequest(endpoint: String,
                     method: HTTPMethod,
                     params: JSONDict,
                     completion: @escaping ResultBlock) {
        let url = URL(string: urlString + endpoint)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(AsyncResult.Failure(error as NSError))
            }
            else if let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data) as? JSONDict else {
                    completion(AsyncResult.Failure(NSError(domain: "",
                                                           code: 2,
                                                           userInfo: nil)))
                    return
                }
                completion(AsyncResult.Success(json))
            }
        }
        task.resume()
    }
    
    func imageRequest(id: String,
                      method: HTTPMethod,
                      completion: @escaping ImageBlock) {
        // Check cache and return
        if let image = imageCache[id] {
            completion(image)
            return
        }
        
        let url = URL(string: cloudinaryUrl + id)!
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let _ = error {
                return
            }
            else if let data = data,
                let image = UIImage(data: data) {
                self.imageCache[id] = image
                completion(image)
            }
        }
        task.resume()
    }
}
