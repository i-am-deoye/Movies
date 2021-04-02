
import Foundation

enum Features : String {
    case MovieList
    
    func url(endpoint: String, parameters: Parameters!=nil) -> String {
        
        guard let endpoints = Bundle.main.url(forResource: "Endpoints", withExtension: "plist") else  { fatalError("Unable to determine URL for endpoints plist") }
        
        guard let fileContents  = NSDictionary(contentsOf: endpoints) else {
            fatalError("Unable to load plist")
        }
        
        guard let feature = fileContents.value(forKey: self.rawValue) as? [String: [String:String]]? else {
            fatalError("Unable to load feature for specifed feature type \(self.rawValue)")
        }
        
        
        guard let endpointItems = feature?[endpoint] else {
            fatalError("Unable to load endpointItems for specifed feature type \(endpoint)")
        }
        
        let environment = Configuration.environment
        let parametersString = parameters == nil ? "" : parameters.stringFromHttpParameters
        let liveUrl = environment.baseURL + (endpointItems["live"] ?? "") + parametersString
        let mockUrl = environment.baseURL + (endpointItems["mock"] ?? "")
        
        guard environment != .Mock else { return mockUrl }
        
        
        return liveUrl
    }
}



struct Endpoints {
    enum MovieList : String {
        case fetchMovies
    }
}
