import UIKit

struct MoviesDetailFactory {
    static func makeViewController(itemModel: ItemModel) -> UIViewController {
        let viewModel = MoviesDetailsViewModel(selectedMovie: itemModel)
        return MoviesDetailsViewController(viewModel: viewModel)
    }
}
