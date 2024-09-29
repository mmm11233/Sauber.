import UIKit

struct MoviesListFactory {
    static func makeView(
        items: [ItemModel],
        type: MovieType
    ) -> MoviesListView {
        let networkManager = NetworkManager()
        let viewModel = MoviesListViewModel(items: items, itemType: type, networkManager: networkManager)
        
        return MoviesListView(viewModel: viewModel)
    }
}
