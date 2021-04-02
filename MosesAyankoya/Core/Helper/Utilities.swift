import Foundation

final class Utilities {
    
    static func threadBackground(_ background: @escaping (() -> Void)) {
        DispatchQueue.global(qos: .background).async {
            background()
        }
    }
    
    static func threadMain(_ main: @escaping (() -> Void)) {
        DispatchQueue.main.async {
            main()
        }
    }
    

    static func decode<T:Decodable> (_ json: Dictionary<AnyHashable, Any>) -> T? {
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) else { return nil }
        guard let value = try? JSONDecoder().decode(T.self, from: data) else { return nil }
        return value
    }
    
    static func decode<T:Decodable> (_ data: Data, cast: T.Type) -> T? {
        guard let value = try? JSONDecoder().decode(cast, from: data) else { return nil }
        print("Response : " + "\(value)")
        return value
    }

}
