
import Foundation

extension Dictionary {
    
    var stringFromHttpParameters : String {
        guard !self.isEmpty else { return "" }
        
        var parametersString = ""
        for (key, value) in self {
            if let key = key as? String,
                let value = value as? String {
                parametersString = parametersString + key + "=" + value + "&"
            }
        }
        parametersString = String(parametersString[..<parametersString.index(before: parametersString.endIndex)])
        return parametersString
    }
}
