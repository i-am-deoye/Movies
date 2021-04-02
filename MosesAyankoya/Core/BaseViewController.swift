

import UIKit


class BaseViewController : UIViewController {
    func showMessage(message: String, event: (() -> ())?) {
        showMessage(addCancel: false, message: message, eventOk: event, eventCancel: nil)
    }
    
    func showMessage(addCancel: Bool=true, message: String, eventOk: (() -> ())?, eventCancel: (() -> ())?) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        let attributedString = NSAttributedString(string: "Message", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.gray])
        
        alertController.setValue(attributedString, forKey: "attributedTitle")
        alertController.view.tintColor = UIColor.gray
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        { (result : UIAlertAction) -> Void in
            eventOk?()
        }
        alertController.addAction(okAction)
        
        if addCancel {
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                eventCancel?()
            }))
        }
        
        
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
