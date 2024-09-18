import Foundation
import UIKit

final class ListService {
    
    private let apiService: NetworkManager
    
    init(
        apiService: NetworkManager
    ) {
        self.apiService = apiService
    }
    
    func fetchMovies(page: Int, completion: @escaping (Result<[ItemModel], Error>) -> Void) {
        guard let url = URL(string: "\(EndpointRepository.topRetedMovies)\(String(page))") else { return }
        apiService.fetchData(from: url) { (result: Result<MoviesResponse, Error>) in
            completion(result.map { item in
                return item.results.map { item in
                    ItemModel(with: item)
                }
            })
        }
    }
    
    func fetchSeries(page: Int, completion: @escaping (Result<[ItemModel], Error>) -> Void) {
        guard let url = URL(string: "\(EndpointRepository.popularTvSeries)\(String(page))") else { return }
        apiService.fetchData(from: url) { (result: Result<SeriesResponse, Error>) in
            completion(result.map { item in
                return item.results.map { item in
                    ItemModel(with: item)
                }
            })
        }
    }
}

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

struct ItemModel {
    let originalLanguage: String?
    let originalName: String?
    let overview: String?
    let popularity: Double
    let posterPath: String?
    let name: String?
    let originalTitle: String?
    let voteAverage: Double
    
    
    init(
        originalLanguage: String?,
        originalName: String?,
        overview: String?,
        popularity: Double,
        posterPath: String?,
        name: String?,
        originalTitle: String?,
        voteAverage: Double
    ) {
        self.originalLanguage = originalLanguage
        self.originalName = originalName
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.name = name
        self.originalTitle = originalTitle
        self.voteAverage = voteAverage
    }
    
    init(with item: Movie) {
        originalLanguage = item.originalLanguage
        originalName = item.originalName
        name = item.name ?? ""
        popularity = item.popularity
        posterPath = item.posterPath
        originalTitle = item.originalTitle
        overview = item.overview
        voteAverage = item.voteAverage
    }
    
    init(with item: Series) {
        originalLanguage = item.originalLanguage
        originalName = item.originalName
        name = item.name ?? ""
        popularity = item.popularity
        posterPath = item.posterPath
        originalTitle = item.originalTitle
        overview = item.overview
        voteAverage = item.voteAverage
    }
}
