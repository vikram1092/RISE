import Foundation

struct Photo: CustomStringConvertible, Equatable {
    let id: String
    let type: String
    
    fileprivate init(id: String, type: String) {
        self.id = id
        self.type = type
    }
    
    static func fromJSON(_ dict: JSONDict) -> Photo? {
        let extractor = JSONExtractor(dict)
        let type = extractor.getString("type")
        let id = extractor.getString("id")
        
        if type != "rectangle" {
            return nil
        }
        
        return extractor.checkAndPassThru(
            Photo(id: id, type: type)
        )
    }
    
    // MARK: printable
    
    var description: String {
        return "photo: \(id)"
    }
}
