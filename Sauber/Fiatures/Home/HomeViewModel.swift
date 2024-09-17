import Foundation
import UIKit
import Combine

//MARK: - Home View Model

protocol HomeViewModelProviding {
    func fetchMoviesAndSerials()
    var moviesDidLoadPublisher: AnyPublisher<Void, Never> { get }
    func numberOfRowsInSection() -> Int
    func item(at index: Int, in section: Int) -> HomeTableViewCellMovieModel?
    func didSelectRowAt(at index: Int, from viewController: UIViewController)
    func movies(section: Int,from viewController: UIViewController) -> MoviesResponse?
    func serials(section: Int,from viewController: UIViewController) -> MoviesResponse?
}

//MARK: - Home View Model

final class HomeViewModel: HomeViewModelProviding {
    
    //MARK: - Properties
    
    private let isLoadingSubject: CurrentValueSubject<Bool, Never> = .init(false)
    private let moviesDidLoadSubject: PassthroughSubject<Void, Never> = .init()
    var moviesDidLoadPublisher: AnyPublisher<Void, Never> { moviesDidLoadSubject.eraseToAnyPublisher()
    }
    private var movieResponse: MoviesResponse?
    private var serialResponse: MoviesResponse?
    private var networkManager: NetworkManager
    
    //MARK: - Init
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    //MARK: - Table View Data Source
    
    func numberOfRowsInSection() -> Int {
        2
    }
    
    func item(at index: Int, in section: Int) -> HomeTableViewCellMovieModel? {
        switch section {
        case 0:
            if let movieResponse {
                return HomeTableViewCellMovieModel(moviesResponse: movieResponse, movirGenreName: "", movieName: "", movieImage: "", moviesOriginalName: "", movieRating: 0.0, movieOverwiev: "")
            }
        case 1:
            if let serialResponse {
                return HomeTableViewCellMovieModel(moviesResponse: serialResponse, movirGenreName: "", movieName: "", movieImage: "", moviesOriginalName: "", movieRating: 0.0, movieOverwiev: "")
            }
        default:
            " "
        }
        return nil
    }
    
    //MARK: - Functions
    
    func movies(section: Int, from viewController: UIViewController) -> MoviesResponse? {
        
        guard let movieResponse = movieResponse else {
            return nil
        }
        
        let movies = movieResponse.results
        let viewModel = MoviesListViewModel(passedMovie: movies)
        let vc = MoviesListViewController(viewModel: viewModel)
        viewController.navigationController?.pushViewController(vc, animated: true)
        return movieResponse
    }
    
    func serials(section: Int,from viewController: UIViewController) -> MoviesResponse? {
        
        guard let serialResponse = serialResponse else {
            return nil
        }
        
        let serials = serialResponse.results
        let viewModel = MoviesListViewModel(passedMovie: serials)
        let vc = MoviesListViewController(viewModel: viewModel)
        viewController.navigationController?.pushViewController(vc, animated: true)
        return serialResponse
    }
    
    // MARK: - UserInteraction
    
    func didSelectRowAt(at index: Int, from viewController: UIViewController) {
        
        guard let movieResponse = movieResponse, index < movieResponse.results.count else {
            return
        }
        
        let selectedMovie = movieResponse.results[index]
        let viewModel = MoviesDetailsViewModelImpl(selectedMovie: selectedMovie)
        let vc = MoviesDetailsViewController(viewModel: viewModel)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Fetch data
    
    func fetchMoviesAndSerials() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        Services(networkmanager: NetworkManager()).fetchMovies(page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.movieResponse = model
            case .failure(let error):
                print("Error fetching movies: \(error)")
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        
        Services(networkmanager: NetworkManager()).fetchSerials(page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.serialResponse = model
            case .failure(let error):
                print("Error fetching serials: \(error)")
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.moviesDidLoadSubject.send(())
        }
    }
}
