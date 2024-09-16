import UIKit

final class MoviesListViewModel {
    
    var recivedMovies: [Movie]
    
    init(
        passedMovie: [Movie]
    ) {
        self.recivedMovies = passedMovie
    }
}
