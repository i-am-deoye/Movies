
import Foundation

typealias Payload = MovieItem
struct MovieItem : Equatable {
    
    var title : String = ""
    var year : String = ""
    var rated : String = ""
    var released : String = ""
    var runtime : String = ""
    var genre : String = ""
    var director : String = ""
    var writer : String = ""
    var actors : String = ""
    var plot : String = ""
    var language : String = ""
    var country : String = ""
    var awards : String = ""
    var poster : String = ""
    var ratings = [Rating]()
    var metascore : String = ""
    var imdbRatings : String = ""
    var imdbVotes : String = ""
    var imdbID : String = ""
    var type: String = ""
    var totalSeasons : String = ""
    var response : String = ""
    
    
    static func map(_ json: [String:Any]) -> MovieItem? {
        guard !json.isEmpty else { return nil }
        return MovieItem.init(title: json["Title"] as? String ?? "",
                              year: json["Year"] as? String ?? "",
                              rated: json["Rated"] as? String ?? "",
                              released: json["Released"] as? String ?? "",
                              runtime: json["Runtime"] as? String ?? "",
                              genre: json["Genre"] as? String ?? "",
                              director: json["Director"] as? String ?? "",
                              writer: json["Writer"] as? String ?? "",
                              actors: json["Actors"] as? String ?? "",
                              plot: json["Plot"] as? String ?? "",
                              language: json["Language"] as? String ?? "",
                              country: json["Country"] as? String ?? "",
                              awards: json["Awards"] as? String ?? "",
                              poster: json["Poster"] as? String ?? "",
                              ratings: (json["Ratings"] as? [[String:Any]] ?? [[String:Any]]()).compactMap{ Rating.map($0) },
                              metascore: json["Metascore"] as? String ?? "",
                              imdbRatings: json["imdbRating"] as? String ?? "",
                              imdbVotes: json["imdbVotes"] as? String ?? "",
                              imdbID: json["imdbID"] as? String ?? "",
                              type: json["Type"] as? String ?? "",
                              totalSeasons: json["totalSeasons"] as? String ?? "",
                              response: json["Response"] as? String ?? "")
    }
    
    func hashValue() -> Int {
        return "\(title.hashValue)\(poster.hashValue)\(year.hashValue)\(director.hashValue)".hashValue
    }
    
    static func == (lhs: MovieItem, rhs: MovieItem) -> Bool {
        return lhs.hashValue() == rhs.hashValue()
    }
}

struct Rating {
    let source: String
    let value : String
    
    static func map(_ json: [String: Any]) -> Rating {
        return Rating.init(source: json["Source"] as? String ?? "",
                           value: json["Value"] as? String ?? "")
    }
}

