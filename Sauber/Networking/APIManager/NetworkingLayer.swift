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
        
        if let cachedImage = imageCache.object(forKey: cacheKey) {
            completion(.success(cachedImage))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NetworkError.requestFailed))
                
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(NetworkError.decodingFailed))
                
                return
            }
            
            self.imageCache.setObject(image, forKey: cacheKey)
            completion(.success(image))
        }
        
        task.resume()
    }
}
