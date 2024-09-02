import Foundation
import UIKit
import Combine

//MARK: - Home View Model

protocol HomeViewModel {
    var moviesDidLoadPublisher: AnyPublisher<Void, Never> { get }
    func ViewDidLoad()
    func numberOfRowsInSection() -> Int
    func item(at index: Int) -> HomeTableViewCellModel?
    func didSelectRowAt(at index: Int, from viewController: UIViewController)

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
    
    // MARK: User Interaction
    func didSelectRowAt(at index: Int, from viewController: UIViewController) {
        let vc = MoviesDetailsViewController(viewModel: MoviesDetailsViewModelImpl(selectedMovie: (movieResponse?.results[index])!))
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchMovies() {
        if let url = URL(string: EndpointRepository.topRatedEndpoint) {
            
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
