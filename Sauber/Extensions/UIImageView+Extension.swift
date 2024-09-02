//
//  UIImageView+Extension.swift
//  Sauber
//
//  Created by Mariam Joglidze on 02/09/2024.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL, placeholder: UIImage? = nil) {
        // Set placeholder image if provided
        self.image = placeholder
        
        // Fetch the image
        NetworkManager().fetchImage(from: url) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.image = image
                case .failure(let error):
                    print("Error loading image: \(error)")
                    // Optionally, set a failure placeholder image
                }
            }
        }
    }
}
