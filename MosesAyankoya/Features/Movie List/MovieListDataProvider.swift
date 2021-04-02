

import UIKit


protocol IMovieListDataProvider : UITableViewDelegate, UITableViewDataSource {
    var movies : [MovieItem] { get set }
    var onSelected : ((_ item: MovieItem) -> Void)? { get set }
}

class MovieListDataProvider : NSObject, IMovieListDataProvider {
    var movies = [MovieItem]()
    var onSelected: ((MovieItem) -> Void)?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieItemCell.name, for: indexPath) as! MovieItemCell
        cell.item = movies[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = movies[indexPath.item]
        guard let handler = onSelected else { return }
        handler(item)
    }
}
