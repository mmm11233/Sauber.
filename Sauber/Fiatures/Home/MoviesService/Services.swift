import Foundation
import UIKit

// MARK: - Movies Services

final class Services {
    
    private let networkmanager: NetworkManager
    
    init(
        networkmanager: NetworkManager
    ) {
        self.networkmanager = networkmanager
    }
    
    func fetchMovies(page: Int, completion: @escaping (Result<MoviesResponse, Error>) -> Void) {
        let urlString = "\(EndpointRepository.topRatedEndpoint)\(page)"
        if let url = URL(string: urlString) {
            
            networkmanager.fetchData(from: url) { (result: Result<MoviesResponse, Error>) in
                switch result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    print("Error fetching data: \(error)")
                    completion(.failure(error))
                }
            }
        }
    }
    
    func fetchSerials(page: Int, completion: @escaping (Result<MoviesResponse, Error>) -> Void) {
        
        let urlString = "\(EndpointRepository.popularEndpoint)\(page)"
        if let url = URL(string: urlString) {
            
            networkmanager.fetchData(from: url) { (result: Result<MoviesResponse, Error>) in
                switch result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    print("Error fetching data: \(error)")
                    completion(.failure(error))
                }
            }
        }
    }
}

// MARK: - Cache image

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithURL(posterPath: String?) {
        
        guard let posterPath = posterPath else {
            self.image = nil
            return
        }
        
        let urlString = "\(EndpointRepository.imageBaseURL)\(posterPath)"
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                if let downloadImage = UIImage(data: data!) {
                    imageCache.setObject(downloadImage, forKey: urlString as AnyObject)
                    self.image = downloadImage
                }
            }
        }).resume()
    }
}
