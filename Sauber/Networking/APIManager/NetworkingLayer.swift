import UIKit

protocol NetworkService {
    func fetchData<T: Decodable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

final class NetworkManager: NetworkService {
    private let urlSession: URLSession
    private let parser: DataParser
    
    private let imageCache = NSCache<NSString, UIImage>()

    init(urlSession: URLSession = .shared, parser: DataParser = JSONDataParser()) {
        self.urlSession = urlSession
        self.parser = parser
    }
    
    func fetchData<T: Decodable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let request = URLRequest(url: url)
        
        let task = urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.requestFailed))
                return
            }
            
            do {
                let decodedData = try self.parser.parse(data, as: T.self)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let cacheKey = url.absoluteString as NSString
        
        // Check if the image is already in the cache
        if let cachedImage = imageCache.object(forKey: cacheKey) {
            completion(.success(cachedImage))
            return
        }
        
        // Create a URLSession data task to download the image
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for errors
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Check that the response status code is 200
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NetworkError.requestFailed))
                return
            }
            
            // Check that the data is not nil
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(NetworkError.decodingFailed))
                return
            }
            
            // Cache the image
            self.imageCache.setObject(image, forKey: cacheKey)
            
            // Return the image
            completion(.success(image))
        }
        
        // Start the task
        task.resume()
    }
}
