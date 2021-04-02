
import Foundation


protocol IMovieListViewModel {
    var remoteRepository : IMovieListRemoteRepository! { get set }
    var movies : Dynamic<StateModel<List<MovieItem>>> { get }
    func getMovies()
}

class MovieListViewModel : IMovieListViewModel {
    var remoteRepository: IMovieListRemoteRepository!
    var movies = Dynamic.init(StateModel<List<MovieItem>>.init(state: State<List<MovieItem>>.none))
    fileprivate var container = [MovieItem]()
    
    func getMovies() {
        if let parameters = readJsonData(resource: "movies_query_parameters") as? Array<Parameters> {
            self.container.removeAll()
            let initialState : State<List<MovieItem>> = State.loading
            self.movies.value = StateModel<List<MovieItem>>.init(state: initialState)
            
            parameters.forEach { (parameter) in
                self.remoteRepository.getMovie(by: parameter, response: self.onGetMovie)
            }
        }
        
    }
}



extension MovieListViewModel {
    
    fileprivate func onGetMovie(response: Response) {
        switch response {
            
        case .error(let errorMessage):
            let state : State<List<MovieItem>> = State.error(errorMessage)
            self.movies.value = StateModel<List<MovieItem>>.init(state: state)
            break
            
        case .success(let message, let movies):
            self.container.append(movies.first!)
            let list = List<MovieItem>.init(list: self.container)
            let state : State<List<MovieItem>> = State.dataLoaded(list, message)
            self.movies.value = StateModel<List<MovieItem>>.init(state: state)
            break
        }
    }
}
