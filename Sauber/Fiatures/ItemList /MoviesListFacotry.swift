import UIKit

struct MoviesListFactory {
    static func makeViewController(items: [ItemModel], with itemType: MovieType) -> UIViewController {
        let networkManager = NetworkManager()
        let service = ListService(apiService: networkManager)
        let viewModel = MoviesListViewModel(items: items, itemType: itemType, networkManager: networkManager)
        
        return MoviesListViewController(viewModel: viewModel)
    }
}
