
import UIKit

class MovieItemCell: UITableViewCell {
    static let name = "MovieItemCell"
    @IBOutlet weak var director : UILabel!
    @IBOutlet weak var titleLB : UILabel!
    @IBOutlet weak var yearOfProduction : UILabel!
    @IBOutlet weak var artworkImage : UIImageView!
    @IBOutlet weak var indicatorView : UIActivityIndicatorView!
    
    
    var item : MovieItem! {
        
        didSet {
            titleLB.text = item.title
            yearOfProduction.text = item.released
            director.text = item.director
            self.artworkImage.set(item.poster, identifier: item.imdbID, progress: indicatorView)
        }
    }
    
}
