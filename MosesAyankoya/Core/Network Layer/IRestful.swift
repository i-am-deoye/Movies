

import Foundation

public typealias JSON = [String : Any]
public typealias URLConvertible = String
public typealias HTTPHeaders = [String : String]
public typealias Parameters = Dictionary<String,String>
public typealias Headers = [String: String]

protocol IRestful {
    func get(url: String, handle: @escaping ((Response) -> Void) )
}
