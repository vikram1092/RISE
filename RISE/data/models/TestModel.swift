class TestModel {
    let ping: String
    
    init(withJson json: JSONDict) {
        ping = json["ping"] as! String
    }
}
