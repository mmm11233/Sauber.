import Foundation

protocol NetworkService {
    func fetchData<T: Decodable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

final class NetworkManager: NetworkService {
    private let urlSession: URLSession
    private let parser: DataParser
    
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
}
