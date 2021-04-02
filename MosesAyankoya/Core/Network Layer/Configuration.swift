
import Foundation

public enum Environment: String {
    case Development = "Development"
    case Release = "Release"
    case Mock = "Mock"
    
    var baseURL: String {
        switch self {
        case .Development: return "http://www.omdbapi.com/?apikey=1fe468b0&"
        case .Release: return "http://www.omdbapi.com/?apikey=1fe468b0&"
        case .Mock: return ""
        }
    }
}

public struct Configuration {
    
    
    public static var environment: Environment = {
        guard let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String else {
            fatalError()
        }
        
        if configuration.range(of: Environment.Release.rawValue) != nil {
            return Environment.Release
        }else if configuration.range(of: Environment.Development.rawValue) != nil {
            return Environment.Development
        }else if configuration.range(of: Environment.Mock.rawValue) != nil {
            return Environment.Mock
        }else{
            fatalError()
        }
    }()
    
    
}
