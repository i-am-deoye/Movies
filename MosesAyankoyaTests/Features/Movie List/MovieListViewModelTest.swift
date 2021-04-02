


import XCTest
@testable import MosesAyankoya

class MovieListViewModelTest: XCTestCase {
    
    var mockLocationRemoteRepository : IMovieListRemoteRepository!
    var sut : IMovieListViewModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = MockMovieListViewModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_empty_movie_parameters() {
        let expectation = self.expectation(description: "test_empty_movie_parameters")
        
        let sut = (self.sut as! MockMovieListViewModel)
        sut.isDataFetched = true
        sut.empty = true
        
        var expected = MovieItem.init()
        expected.year = ""
        expected.director = ""
        expected.poster = ""
        expected.title = ""
        
        var result : MovieItem?
        
        
        sut.movies.bindAndFire { (stateModel) in
            switch stateModel.state {
            case .dataLoaded(let list, _) :
                result = list.list.first
                expectation.fulfill()
            default:
                break
            }
        }
        
        sut.getMovie(by: [])
        
        // Assert
        XCTAssertEqual(expected, result)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_non_empty_movie_parameters() {
        let expectation = self.expectation(description: "test_non_empty_movie_parameters")
        
        let sut = (self.sut as! MockMovieListViewModel)
        sut.isDataFetched = true
        sut.empty = false
        
        var expected = MovieItem.init()
        expected.year = "1990"
        expected.director = "John Doe"
        expected.poster = "https://m.media-amazon.com/images/M/MV5BZDc1NzI2MGEtZDA2Yy00ZWExLTgwYmItNjU3N2QyYmM0MzYwXkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_SX300.jpg"
        expected.title = "Test Moment War"
        
        var result : MovieItem?
        
        
        sut.movies.bindAndFire { (stateModel) in
            switch stateModel.state {
            case .dataLoaded(let list, _) :
                result = list.list.first
                expectation.fulfill()
            default:
                break
            }
        }
        
        sut.getMovie(by: [])
        
        // Assert
        XCTAssertEqual(expected, result)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_empty_movie() {
        let expectation = self.expectation(description: "test_empty_movie")
        
        let sut = (self.sut as! MockMovieListViewModel)
        sut.isDataFetched = false
        
        var expected : MovieItem?
        
        var result : MovieItem?
        
        
        sut.movies.bindAndFire { (stateModel) in
            switch stateModel.state {
            case .dataLoaded(let list, _) :
                result = list.list.first
                expectation.fulfill()
            default:
                break
            }
        }
        
        sut.getMovie(by: [])
        
        // Assert
        XCTAssertEqual(expected, result)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_fetch_movies_with_error_message() {
        let expectation = self.expectation(description: "test_fetch_movies_with_error_message")
        
        let sut = (self.sut as! MockMovieListViewModel)
        sut.isError = true
        
        var expected : String = "error"
        
        var result : String?
        
        
        sut.movies.bindAndFire { (stateModel) in
            switch stateModel.state {
            case .error(let message) :
                result = message
                expectation.fulfill()
            default:
                break
            }
        }
        
        sut.getMovie(by: [])
        
        // Assert
        XCTAssertEqual(expected, result)
        waitForExpectations(timeout: 5, handler: nil)
    }

}
