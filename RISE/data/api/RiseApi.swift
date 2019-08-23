import RxSwift
import RxCocoa
import Alamofire
import RxAlamofire

public enum AsyncResult <T> {
    case Success(T)
    case Loading
    case Failure(NSError)
    
    static func from(json: JSONDict,
                     withMapper mapper: (JSONDict) -> T?) -> AsyncResult<T> {
        
        if let object = mapper(json) {
            return Success(object)
        } else if let error = json["error"] as? Error {
            return Failure(error as NSError)
        } else {
            return Failure(NSError(domain: "", code: 1, userInfo: [:]) )
        }
    }
}

extension AsyncResult where T == Data {
    /**
     * Takes a json Dictionary and converts to an AsyncResult, unwrapping API errors if they exist.
     */
    static func from(data: Data) -> AsyncResult<Data> {
        return AsyncResult.Success(data)
    }
}

extension AsyncResult where T == JSONDict {
    /**
     * Takes a json Dictionary and converts to an AsyncResult, unwrapping API errors if they exist.
     */
    static func from(data: Data) -> AsyncResult<JSONDict> {
        
        if let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? JSONDict {
            // Map to JSON Dict
            return AsyncResult.Success(json)
        } else {
            // Throw JSON serialization error
            return AsyncResult.Failure(NSError(domain: "",
                                               code: 0,
                                               userInfo: [:]))
        }
    }
}

class RiseApi {
    static let shared = RiseApi()
    fileprivate let baseUrl = "https://alx-rise.herokuapp.com"
    fileprivate var sessionManager = APISessionManager()
    
    func request(endpoint: String,
                 method: HTTPMethod,
                 params: JSONDict,
                 resultHandler: @escaping ResultBlock) {
        sessionManager.dataRequest(endpoint: endpoint,
                                   method: method,
                                   params: params,
                                   completion: resultHandler)
    }
    
    func getPhoto(id: String, imageBlock: @escaping ImageBlock) {
        sessionManager.imageRequest(id: id,
                                   method: .get,
                                   completion: imageBlock)
    }
    
    static func mapTestResponse(json: JSONDict) -> TestModel? {
        let testModel = try! TestModel(JSON: json)
        return testModel
    }
    
    static func mapListingsResponse(json: JSONDict) -> [Listing]? {
        let listings = try! Listings(JSON: json)
        return listings.list
    }
    
    static func mapRentalIdResponse(json: JSONDict) -> DetailedListing? {
        let listing = try! DetailedListing(JSON: json)
        return listing
    }
}
