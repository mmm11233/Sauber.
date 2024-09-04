import UIKit

// MARK: - Movies Details View Model Impl
final class MoviesDetailsViewModelImpl {
    var selectedMovie: Movie
    
    init(
        selectedMovie: Movie
    ) {
        self.selectedMovie = selectedMovie
    }
    
    func getTitle() -> String {
        selectedMovie.originalName ?? ""
    }
    
    func getSubtitle() -> String {
        selectedMovie.name ?? ""
    }
    
    func getDescription() -> String {
        selectedMovie.overview ?? "empty description"
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        func downloadImage(from url: URL,  completion: @escaping (UIImage?) -> Void) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    completion((UIImage(data: data)))
                } else {
                    completion(nil)
                }
            }.resume()
        }
    }
}
