import Foundation
import UIKit
import Combine

//MARK: - Home View Model

protocol HomeViewModelProviding {
    func fetchMoviesAndSerials()
    var moviesDidLoadPublisher: AnyPublisher<Void, Never> { get }
    func numberOfRowsInSection() -> Int
    func item(at index: Int, in section: MovieType) -> HomeTableViewCellMovieModel?
    func didSelectRowAt(at index: Int, from viewController: UIViewController)
    func movies(section: MovieType,from viewController: UIViewController)
    func serials(section: MovieType,from viewController: UIViewController)
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
    
    func item(at index: Int, in section: MovieType) -> HomeTableViewCellMovieModel? {
        switch section {
        case .movies:
            if let movieResponse {
                return HomeTableViewCellMovieModel(moviesResponse: movieResponse, movirGenreName: "", movieName: "", movieImage: "", moviesOriginalName: "", movieRating: 0.0, movieOverwiev: "")
            }
        case .serials:
            if let serialResponse {
                return HomeTableViewCellMovieModel(moviesResponse: serialResponse, movirGenreName: "", movieName: "", movieImage: "", moviesOriginalName: "", movieRating: 0.0, movieOverwiev: "")
            }
        }
        return nil
    }
    
    //MARK: - Functions
    
    func movies(section: MovieType, from viewController: UIViewController) {
        guard let movieResponse = movieResponse else {
            return
        }
        
        let movies = movieResponse.results
        let viewModel = MoviesListViewModel(passedMovie: movies)
        let vc = MoviesListViewController(viewModel: viewModel)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func serials(section: MovieType,from viewController: UIViewController) {
        guard let serialResponse = serialResponse else {
            return
        }
        
        let serials = serialResponse.results
        let viewModel = MoviesListViewModel(passedMovie: serials)
        let vc = MoviesListViewController(viewModel: viewModel)
        viewController.navigationController?.pushViewController(vc, animated: true)
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
