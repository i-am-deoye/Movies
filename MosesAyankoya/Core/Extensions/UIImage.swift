
import UIKit

extension UIImage {
    
    static func getImage(data: Data?=nil, identifier: String ) -> UIImage? {

        let preferences: UserDefaults = UserDefaults.standard
        
        if let data = data {
            preferences.set(data, forKey: identifier)
            return UIImage.init(data: data)
        } else {
            
            guard let saved = preferences.value(forKey: identifier) as? Data else {
                return nil
            }
            
            return UIImage.init(data: saved)
        }
    }
}
