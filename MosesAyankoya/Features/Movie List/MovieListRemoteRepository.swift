

import Foundation

protocol IMovieListRemoteRepository {
    mutating func getMovie(by parameter: Parameters, response: @escaping ((Response) -> Void) )
}

struct MovieListRemoteRepository : IRemoteRepository, IMovieListRemoteRepository {
    
    var httpBody: HTTPBodyType
    
    init() {
        httpBody = HTTPBodyType.payload
    }
    
    mutating func getMovie(by parameter: Parameters, response: @escaping ((Response) -> Void)) {
        httpBody = HTTPBodyType.parameter
        get(url: Features.MovieList.url(endpoint: Endpoints.MovieList.fetchMovies.rawValue, parameters: parameter), handle: response)
    }
}
