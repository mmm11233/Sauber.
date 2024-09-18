import Foundation
import UIKit
import Combine

//MARK: - Home View Model

protocol HomeViewModelProviding {
    func numberOfRowsInSection() -> Int
    func item(at index: Int, in section: MovieType) -> [ItemModel]?
    func didSelectRowAt(at index: Int, from viewController: UIViewController)
    func toSelectedItem(section: MovieType,from viewController: UIViewController)
}

final class HomeViewModel {
    
    //MARK: - Properties
    
    private let moviesItemSubject = CurrentValueSubject<[ItemModel], Error>([])
    private(set) lazy var moviesItems: AnyPublisher<[ItemModel], Never> = moviesItemSubject.replaceError(with: []).eraseToAnyPublisher()
    
    @Published var fetchingState: FetchingState = .loading
    
    // MARK: - Dependencies
    
    private let listService: ListService
    
    //MARK: - Init
    
    init(
        listService: ListService
    ) {
        self.listService = listService
        // is it correct to call the fetchMovies() function in here
        fetchMovies()
    }
    
    func fetchMovies() {
        fetchingState = .loading
        listService.fetchMovies(page: 1, completion: handleApiResponse)
    }
}

private extension HomeViewModel {
    func handleApiResponse(_ result: Result<[ItemModel], Error>) {
        switch result {
        case .success(let items):
            moviesItemSubject.send(items)
            fetchingState = .finished
        case .failure(let error):
            fetchingState = .error(error)
        }
    }
}


extension HomeViewModel: HomeViewModelProviding {
    func numberOfRowsInSection() -> Int {
        2
    }
    
    func item(at index: Int, in section: MovieType) -> [ItemModel]? {
        switch section {
        case .movies:
            return moviesItemSubject.value
        case .series:
            return moviesItemSubject.value
        }
    }
    
    //MARK: - Functions
    
    func toSelectedItem(section: MovieType, from viewController: UIViewController) {
        //make the correct implementation of the series section
        if section == .movies {
            let moviesListViewController = MoviesListFactory.makeViewController(items: moviesItemSubject.value, with: .movies)
            viewController.navigationController?.pushViewController(moviesListViewController, animated: true)
        } else if section == .series {
            let moviesListViewController = MoviesListFactory.makeViewController(items: moviesItemSubject.value, with: .series)
            viewController.navigationController?.pushViewController(moviesListViewController, animated: true)
        }
    }
    
    // MARK: - UserInteraction
    
    func didSelectRowAt(at index: Int, from viewController: UIViewController) {
        let selectedMovie = moviesItemSubject.value[index]
        let viewModel = MoviesDetailsViewModelImpl(selectedMovie: selectedMovie)
        let vc = MoviesDetailsViewController(viewModel: viewModel)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}

enum FetchingState {
    case loading
    case finished
    case error(Error)
}
