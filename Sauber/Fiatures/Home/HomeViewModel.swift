import Foundation
import UIKit
import Combine

//MARK: - Home View Model

protocol HomeViewModelProviding {
    func numberOfRowsInSection() -> Int
    func item(at index: Int, in section: MovieType) -> [ItemModel]?
    func didSelectRowAt(at index: Int, from viewController: UIViewController, movieType: MovieType)
    func toSelectedItem(section: MovieType,from viewController: UIViewController)
    func fetchMovies()
    func fetchSeries()
}

final class HomeViewModel: ObservableObject {
    
    //MARK: - Properties
    
    private let moviesItemSubject = CurrentValueSubject<[ItemModel], Error>([])
    private(set) lazy var moviesItems: AnyPublisher<[ItemModel], Never> = moviesItemSubject.replaceError(with: []).eraseToAnyPublisher()
    
    private let seriesItemSubject = CurrentValueSubject<[ItemModel], Error>([])
    private(set) lazy var seriesItems: AnyPublisher<[ItemModel], Never> = seriesItemSubject.replaceError(with: []).eraseToAnyPublisher()
    
    @Published var fetchingState: FetchingState = .loading
    
    // MARK: - Dependencies
    
    private let listService: ListService
    @Published var movies: [ItemModel] = []
    @Published var series: [ItemModel] = []
 
    //MARK: - Init
    
    init(
        listService: ListService
    ) {
        self.listService = listService
        fetchMovies()
        fetchSeries()
    }
}

 extension HomeViewModel {
     func handleApiResponse(_ result: Result<[ItemModel], Error>, subject: CurrentValueSubject<[ItemModel], Error>) {
         DispatchQueue.main.async {
             switch result {
             case .success(let items):
                 subject.send(items)
                 self.fetchingState = .finished
             case .failure(let error):
                 self.fetchingState = .error(error)
             }
         }
     }
}


extension HomeViewModel: HomeViewModelProviding {
    
    func fetchMovies() {
        fetchingState = .loading
        listService.fetchMovies(page: 1) { [weak self] result in
            DispatchQueue.main.async {
                self?.handleApiResponse(result, subject: self?.moviesItemSubject ?? CurrentValueSubject([]))
            }
        }
    }
    
    func fetchSeries() {
        fetchingState = .loading
        listService.fetchSeries(page: 1) { [weak self] result in
            DispatchQueue.main.async {
                self?.handleApiResponse(result, subject: self?.seriesItemSubject ?? CurrentValueSubject([]))
                
            }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        2
    }
    
    func item(at index: Int, in section: MovieType) -> [ItemModel]? {
        switch section {
        case .movies:
            return moviesItemSubject.value
        case .series:
            return seriesItemSubject.value
        }
    }
    
    //MARK: - Functions
    
    func toSelectedItem(section: MovieType, from viewController: UIViewController) {
        if section == .movies {
            let moviesListViewController = MoviesListFactory.makeViewController(items: moviesItemSubject.value, with: .movies)
            viewController.navigationController?.pushViewController(moviesListViewController, animated: true)
        } else if section == .series {
            let moviesListViewController = MoviesListFactory.makeViewController(items: seriesItemSubject.value, with: .series)
            viewController.navigationController?.pushViewController(moviesListViewController, animated: true)
        }
    }
    
    // MARK: - UserInteraction
    
    func didSelectRowAt(at index: Int, from viewController: UIViewController, movieType: MovieType) {
        
        var selectedValue: ItemModel
        
        switch movieType {
        case .movies:
            selectedValue = moviesItemSubject.value[index]
        case .series:
            selectedValue = seriesItemSubject.value[index]
        }
        
        let moviesDetailsViewModel = MoviesDetailFactory.makeViewController(itemModel: selectedValue)
        viewController.navigationController?.pushViewController(moviesDetailsViewModel, animated: true)
    }
}

enum FetchingState {
    case loading
    case finished
    case error(Error)
}
