import UIKit

// MARK: - Movies Details View Model

protocol MoviesDetailViewModel {
    var selectedMovie: Movie { get }
    
    func getTitle() -> String
    func getSubtitle() -> String
    func getDescription() -> String
    
//    func downloadImage(from url: URL,  completion: @escaping (UIImage?) -> Void)
}

// MARK: - Movies Details View Model Impl
final class MoviesDetailsViewModelImpl: MoviesDetailViewModel {
    var selectedMovie: Movie
    
    init(selectedMovie: Movie) {
        self.selectedMovie = selectedMovie
    }
    
    func getTitle() -> String {
        selectedMovie.originalName ?? "Mariami"
    }
    
    func getSubtitle() -> String {
        selectedMovie.name ?? "Mariami"
    }
    
    func getDescription() -> String {
        selectedMovie.overview ?? "Mariam Joglidze"
    }
    
//    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
//        <#code#>
//    }
    
    
}


