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
        selectedMovie.originalTitle ?? "empty name"
    }
    
    func getSubtitle() -> String {
        selectedMovie.originalLanguage ?? "empty subtitle"
    }
    
    func getDescription() -> String {
        selectedMovie.overview ?? "empty description"
    }
}
