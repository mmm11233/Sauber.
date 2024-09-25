import UIKit

struct HomeFactory {
    static func makeViewController() -> HomeView {
        let networkManager = NetworkManager()
        let service = ListService(apiService: networkManager)
        let viewModel = HomeViewModel(listService: service)
        
        return HomeView(viewModel: viewModel)
    }
}
