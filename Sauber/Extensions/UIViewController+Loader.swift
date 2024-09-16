import Foundation

import UIKit

// MARK: UIViewController + Loader
extension UIViewController {
    private var activityIndicatorTag: Int {
        return 99999999
    }
    
    func startLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.center = self.view.center
            activityIndicator.tag = self.activityIndicatorTag
            activityIndicator.startAnimating()
            
            self.view.addSubview(activityIndicator)
        }
    }
    
    func stopLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let activityIndicator = self.view.viewWithTag(self.activityIndicatorTag) as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
}
