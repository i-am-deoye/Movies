
import Foundation
@testable import MosesAyankoya


class MockMovieListViewModel : IMovieListViewModel {
    var remoteRepository: IMovieListRemoteRepository!
    var movies = Dynamic.init(StateModel<List<MovieItem>>.init(state: State<List<MovieItem>>.none))
    var isDataFetched = false
    var isError = false
    var empty = false
    
    
    func getMovie(by list: [Parameters]) {
        if isError {
            
            let state : State<List<MovieItem>> = State.error("error")
            let stateModel = StateModel<List<MovieItem>>.init(state: state)
            self.movies.value = stateModel
            
        } else {
            
            if isDataFetched {
                
                var movieEmpty = MovieItem.init()
                movieEmpty.year = ""
                movieEmpty.director = ""
                movieEmpty.poster = ""
                movieEmpty.title = ""
                
                var movie = MovieItem.init()
                movie.year = "1990"
                movie.director = "John Doe"
                movie.poster = "https://m.media-amazon.com/images/M/MV5BZDc1NzI2MGEtZDA2Yy00ZWExLTgwYmItNjU3N2QyYmM0MzYwXkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_SX300.jpg"
                movie.title = "Test Moment War"
                
                let value = empty ? movieEmpty : movie
                let list = List<MovieItem>.init(list: [value])
                let state : State<List<MovieItem>> = State.dataLoaded(list, "success")
                let stateModel = StateModel<List<MovieItem>>.init(state: state)
                self.movies.value = stateModel
                
            } else if !isDataFetched  {
                
                let list = List<MovieItem>.init(list: [])
                let state : State<List<MovieItem>> = State.dataLoaded(list, "success")
                let stateModel = StateModel<List<MovieItem>>.init(state: state)
                self.movies.value = stateModel
            }
        }
    }
    
}
