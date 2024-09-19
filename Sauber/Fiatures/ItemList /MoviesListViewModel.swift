import UIKit
import Combine

final class MoviesListViewModel {
    
    //MARK: - Properties
    
    @Published var fetchingState: FetchingState = .finished
    private let moviesDidLoadSubject: PassthroughSubject<Void, Never> = .init()
    var moviesDidLoadPublisher: AnyPublisher<Void, Never> { moviesDidLoadSubject.eraseToAnyPublisher() }
    
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
        switch itemType {
        case .movies:
            ListService(apiService: networkManager).fetchMovies(page: currentPage) { [ weak self ] result in
                guard let self = self else { return }
                switch result {
                case .success(let model):
                    self.items.append(contentsOf: model)
                    self.moviesDidLoadSubject.send()
                    self.fetchingState = .finished
                case .failure(let error):
                    print("Error fetching movies: \(error)")
                    self.fetchingState = .error(error)
                }
            }
        case .series:
            ListService(apiService: networkManager).fetchSeries(page: currentPage) { [ weak self ] result in
                guard let self = self else { return }
                switch result {
                case .success(let model):
                    self.items.append(contentsOf: model)
                    self.moviesDidLoadSubject.send()
                    self.fetchingState = .finished
                case .failure(let error):
                    print("Error fetching movies: \(error)")
                    self.fetchingState = .error(error)
                }
            }
        }
        currentPage += 1
    }
}
