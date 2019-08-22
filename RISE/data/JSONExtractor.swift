import Foundation
import Alamofire

// A protocol to make it easy to generically instantiate empty classes
protocol BlankInitable {
    init()
}

extension Int : BlankInitable {}
extension Double : BlankInitable {}
extension String : BlankInitable {}
extension Array : BlankInitable {}
extension Dictionary : BlankInitable {}
extension Bool : BlankInitable {}

protocol JSONBuildable {
    static func fromJSON(_ dict: JSONDict) -> Result<Self>
}

// This class is inspired by this article, but using OO state instead of an inout param
// http://commandshift.co.uk/blog/2014/12/28/nice-web-services-swift-edition/

// It will return empty (aka BlankInitable) values in place of invalid values, and collect all the errors it encountered.
final class JSONExtractor {
    let dict: JSONDict
    
    // This property will be set to true if an attempt to extract a value failed
    fileprivate(set) var failed: Bool = false
    
    // Attempted Key -> Reason it failed
    fileprivate(set) var errors = [String: NSError]()
    
    init(_ dict: JSONDict) {
        self.dict = dict
    }
    
    // MARK: convenience accessors
    // TODO: accessors that don't create an error if the key is missing (but do if it's the wrong type of data
    
    func getInt(_ key: String) -> Int {
        return getVal(key)
    }
    
    func getDouble(_ key: String) -> Double {
        return getVal(key)
    }
    
    func getArray<Element>(_ key: String) -> [Element] {
        return getVal(key)
    }
    
    func getJSONDict(_ key: String) -> JSONDict {
        return getVal(key)
    }
    
    func getString(_ key: String) -> String {
        return getVal(key)
    }
    
    func getBool(_ key: String) -> Bool {
        return getVal(key)
    }
    
    /// Gets a date string at `key`, and attempts to convert it to `format`
    func getFormattedDate(_ key: String, format: DateFormat) -> Date {
        let dateString = getString(key)
        // If its blank, don't attempt to format it.
        guard let date = dateString.toDate(format), (dateString != "") else {
            failed = true
            errors[key] = NSError(domain: "", code: 6, userInfo: [:])
            return Date()
        }
        return date
    }
    
    /// Same as getFormattedDate, except it accepts NSNull and nil values.
    func getOptionalFormattedDate(_ key: String, format: DateFormat) -> Date? {
        // NSNull or empty value are both valid for an optional
        guard (dict[key] is NSNull == false) && (dict[key] != nil) else {
            return nil
        }
        
        return getFormattedDate(key, format: format)
    }
    
    // TODO: try some sweet recursive stuff - though the trick would be communicating errors to the root extractor
    
    func getVal<Type : BlankInitable>(_ key: String) -> Type {
        if let val: AnyObject = dict[key] {
            
            if let actual = val as? Type {
                return actual
            } else {
                // Swift doesn't let us print a Type yet
                return fail(key, reason: "\(key) is incorrect type")
            }
            
        } else {
            return fail(key, reason: "\(key) not present")
        }
    }
    
    /**
     Extracts a single model with a custom model mapping.
     - parameters:
     - fromJSON: The mapping from the JSON value to a model
     */
    func getVal<Type: BlankInitable, JSONType>(
        _ key: String,
        fromJSON: (JSONType) -> Result<Type>)
        -> Type
    {
        if let jsonValue = dict[key] as? JSONType {
            
            let result = fromJSON(jsonValue)
            switch result {
            case .success(let value):
                return value
            case .failure(let error):
                return fail(key, error: error as NSError)
            }
            
        } else {
            return fail(key, reason: "\(key) not present")
        }
    }
    
    /**
     Extracts an array of models with a custom model mapping.
     - parameters:
     - fromJSON: The mapping from the JSON value to a model
     */
    func getVal<Type, JSONType>(
        _ key: String,
        eachFromJSON: (JSONType) -> Result<Type>)
        -> [Type]
    {
        if let jsonValues = dict[key] as? [JSONType] {
            
            let results = jsonValues.map(eachFromJSON)
            let result = ResultHelper.reduceResults(results)
            switch result {
            case .success(let value):
                return value
            case .failure(let error):
                return fail(key, error: error as NSError)
            }
            
        } else {
            return fail(key, reason: "\(key) not present")
        }
    }
    
    /**
     "Maybe" in the sense that if there's no key or value, it won't register an error,
     but still return a BlankInitable value.
     */
    func getMaybeVal<Type : BlankInitable>(_ key: String) -> Type {
        if let val: AnyObject = dict[key] {
            
            if let actual = val as? Type {
                return actual
            } else if let _ = val as? NSNull {
                return Type()
            } else {
                // Swift doesn't let us print a Type yet
                return fail(key, reason: "incorrect type")
            }
            
        } else {
            return Type()
        }
    }
    
    /**
     "Maybe" in the sense that if there's no key or value, it won't register an error,
     but still return a BlankInitable value. Accepts arbitrary mapping of JSON
     to models.
     - parameters:
     - fromJSON: The mapping from the JSON value to a model
     */
    func getMaybeVal<Type: BlankInitable, JSONType>(
        _ key: String,
        fromJSON: (JSONType) -> Result<Type>)
        -> Type
    {
        if let jsonValue = dict[key] as? JSONType {
            
            let result = fromJSON(jsonValue)
            switch result {
            case .success(let value):
                return value
            case .failure(let error):
                return fail(key, error: error as NSError)
            }
            
        } else {
            return Type()
        }
    }
    
    fileprivate func fail<Type : BlankInitable>(_ key: String, reason: String) -> Type {
        failed = true
        errors[key] = NSError(domain: "", code: 6, userInfo: [:])
        return Type()
    }
    
    fileprivate func fail<Type : BlankInitable>(_ key: String, error: NSError) -> Type {
        failed = true
        errors[key] = error
        return Type()
    }
    
    var singleError: NSError {
        assert(failed)
        return NSError(domain: "", code: 6, userInfo: [:])
    }
    
    func checkAndPassThru<T>(_ makeObj: @autoclosure () -> T) -> T? {
        if self.failed {
            return nil
        } else {
            return makeObj()
        }
    }
}

// This example exists primarily for documentation
// But can also ensure that changes to the code will build
private struct Example: JSONBuildable {
    let name: String
    let count: Int
    let strings: [String]
    
    static func fromJSON(_ dict: JSONDict) -> Result<Example> {
        let extractor = JSONExtractor(dict)
        let name = extractor.getString("name")
        let count = extractor.getInt("count")
        let strings: [String] = extractor.getArray("strings")
        
        return ResultHelper.objectOrError(
            Example(name: name, count: count, strings: strings),
            extractor: extractor
        )
    }
}

struct ResultHelper {
    /**
     Convenience method which returns Alamofire-specific Result object.
     */
    static func objectOrError<Value>(_ makeObj: @autoclosure () -> Value,
                                     extractor: JSONExtractor) -> Result<Value>
    {
        if extractor.failed {
            return .failure(extractor.singleError)
        }
        
        return .success(makeObj())
    }
    
    /**
     Convenience method which takes an array of Result and returns a Result
     with an array of values and a single NSError if there no values and
     an error in any Result.
     */
    static func reduceResults<Value>(_ results: [Result<Value>])
        -> Result<[Value]>
    {
        var values = [Value]()
        var errors = [NSError]()
        for result in results {
            switch (result) {
            case .success(let value):
                values.append(value)
            case .failure(let error):
                errors.append(error as NSError)
            }
        }
        
        if let firstError = errors.first, values.isEmpty {
            return .failure(NSError(domain: "", code: 7, userInfo: [:]) )
        } else {
            return .success(values)
        }
    }
}
