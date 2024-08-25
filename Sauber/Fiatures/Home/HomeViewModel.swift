import Foundation
import Combine

//MARK: - Home View Model

protocol HomeViewModel {
    var moviesDidLoadPublisher: AnyPublisher<Void, Never> { get }
    func ViewDidLoad()
    func numberOfRowsInSection() -> Int
    func item(at index: Int) -> HomeTableViewCellModel?
}

//MARK: - Home View Model Impl

final class HomeViewModelImpl: HomeViewModel {
    
    //MARK: - Properties
    
    private let isLoadingSubject: CurrentValueSubject<Bool, Never> = .init(false)
    private let moviesDidLoadSubject: PassthroughSubject<Void, Never> = .init()
    var moviesDidLoadPublisher: AnyPublisher<Void, Never> { moviesDidLoadSubject.eraseToAnyPublisher()
    }
    private var movieResponse: MoviesResponse?
    private var networkManager: NetworkManager
    
    //MARK: - Init
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func ViewDidLoad() {
        fetchMovies()
    }
    
    func numberOfRowsInSection() -> Int {
        movieResponse?.results.count ?? 0
    }
    
    func item(at index: Int) -> HomeTableViewCellModel? {
        if let movieResponse {
            return HomeTableViewCellModel(moviesResponse: movieResponse, movirGenreName: "", movieName: "", movieImage: "")
        }
        
        return nil
    }
    
    func fetchMovies() {
        if let url = URL(string: "https://api.themoviedb.org/3/tv/top_rated?api_key=5640b394ad4d380d373cddff07791a1c"){
            
            networkManager.fetchData(from: url) { [weak self] (result: Result<MoviesResponse, Error>) in
                guard let self else { return }
                switch result {
                case .success(let model):
                    self.movieResponse = model
                    self.moviesDidLoadSubject.send(())
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }
        }
    }
}
