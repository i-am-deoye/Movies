

import UIKit


extension UIImageView {
    
    func set(_ urlString: String, identifier: String, progress: UIActivityIndicatorView?=nil) {
        
        if let url = URL.init(string: urlString) {
            if let img = UIImage.getImage(identifier: identifier) {
                
                if let indicatorView = progress {
                   indicatorView.isHidden = true
                }
                
                self.image = img
            } else {
                
                if let indicatorView = progress {
                    indicatorView.startAnimating()
                    indicatorView.isHidden = false
                }
                
                
                let dispatchQueue = DispatchQueue(label: identifier, qos: .background)
                dispatchQueue.async{
                    if let data = try? Data.init(contentsOf: url) {
                        DispatchQueue.main.async {
                            if let indicatorView = progress {
                                indicatorView.isHidden = true
                                indicatorView.stopAnimating()
                            }
                            
                            self.image = UIImage.getImage(data: data, identifier: identifier)
                        }
                    }
                }
            }
        }
        
    }
}
