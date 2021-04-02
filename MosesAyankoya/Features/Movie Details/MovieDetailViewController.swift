
import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var movieThumbnail : UIImageView!
    @IBOutlet weak var movieTitle : UILabel!
    @IBOutlet weak var movieInfo : UILabel!
    @IBOutlet weak var movieDescription : UITextView!
    
    var movie : MovieItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Movie Details"
        populateView()
    }

    private func populateView() {
        movieTitle.text = movie.title
        movieInfo.text = "RELEASE : \(movie.released) | GENRE : " + movie.genre + "  | RUNTIME : " + movie.runtime
        movieDescription.text = movie.plot
        self.movieThumbnail.set(movie.poster, identifier: movie.imdbID)
    }
}
