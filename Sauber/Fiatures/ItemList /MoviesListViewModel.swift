import UIKit
import Combine

final class MoviesListViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var fetchingState: FetchingState = .finished
    
    var currentPage = 1
    var totalPages = 5
    
    // MARK: - Dependencies
    
    var items: [ItemModel]
    let itemType: MovieType
    private let networkManager: NetworkManager
    
    //MARK: - Init
    
    init(
        items: [ItemModel],
        itemType: MovieType,
        networkManager: NetworkManager
    ) {
        self.items = items
        self.itemType = itemType
        self.networkManager = networkManager
    }
    
    //MARK: - Fetch Data
    
    func refreshData() {
        self.fetchingState = .loading
        
        switch itemType {
        case .movies:
            ListService(apiService: networkManager).fetchMovies(page: currentPage) { [ weak self ] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let model):
                        self.items.append(contentsOf: model)
                        self.fetchingState = .finished
                    case .failure(let error):
                        print("Error fetching movies: \(error)")
                        self.fetchingState = .error(error)
                    }
                }
            }
        case .series:
            ListService(apiService: networkManager).fetchSeries(page: currentPage) { [ weak self ] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let model):
                        self.items.append(contentsOf: model)
                        self.fetchingState = .finished
                    case .failure(let error):
                        print("Error fetching movies: \(error)")
                        self.fetchingState = .error(error)
                    }
                }
            }
        }
        currentPage += 1
    }
}
