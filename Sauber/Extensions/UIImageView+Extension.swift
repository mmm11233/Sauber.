import UIKit

extension UIImageView {
    func loadImage(from url: URL, placeholder: UIImage? = nil) {
        self.image = placeholder
        
        NetworkManager().fetchImage(from: url) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.image = image
                case .failure(let error):
                    print("Error loading image: \(error)")
                }
            }
        }
    }
}
