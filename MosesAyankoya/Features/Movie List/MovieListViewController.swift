

import UIKit


class MovieListViewController: BaseViewController {
    @IBOutlet weak var tableView : UITableView! {
        didSet {
            provider = MovieListDataProvider()
            provider.onSelected = on(selected:)
            tableView.delegate = provider
            tableView.dataSource = provider
        }
    }
    
    var provider : IMovieListDataProvider!
    var viewModel : IMovieListViewModel!
    fileprivate var indicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initiateNavigationItems()
        self.bindAndFire()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchMovies()
    }
    
    private func on(selected movie: MovieItem) {
        performSegue(withIdentifier: SegueIdentifier.toMovieDetails.rawValue, sender: movie)
    }
    
}

extension MovieListViewController {
    
    fileprivate func bindAndFire() {
        if !isViewLoaded {
            return
        }
        
        viewModel.movies.bindAndFire { [unowned self] (model) in
            self.indicatorStopAnimating()
            
            switch model.state {
            case .none:
                break
            case .loading:
                self.indicatorStartAnimating()
                break
                
            case .noData:
                self.showMessage(message: "No Data", event: {self.fetchMovies()})
                break
                
            case .error(let errorMessage):
                self.showMessage(message: errorMessage, event: {self.fetchMovies()})
                break
                
            case .dataLoaded(let data, _ ):
                self.provider.movies = data.list
                self.tableView.reloadData()
                break
            }
        }
    }
    
    private func initiateNavigationItems() {
        self.indicatorView.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        navigationItem.title = "Movie List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.indicatorView)
    }
    
    fileprivate func indicatorStopAnimating() {
        indicatorView.stopAnimating()
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    fileprivate func indicatorStartAnimating() {
        indicatorView.startAnimating()
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    fileprivate func fetchMovies() {
        viewModel.getMovies()
    }
}

extension MovieListViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.toMovieDetails.rawValue, let movie = sender as? MovieItem {
            let destination = segue.destination as! MovieDetailViewController
            destination.movie = movie
        }
    }
}

