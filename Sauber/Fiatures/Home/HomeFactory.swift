import UIKit

struct HomeFactory {
    static func makeViewController() -> UIViewController {
        let networkManager = NetworkManager()
        let service = ListService(apiService: networkManager)
        let viewModel = HomeViewModel(listService: service)
        
        return HomeViewController(viewModel: viewModel)
    }
}
