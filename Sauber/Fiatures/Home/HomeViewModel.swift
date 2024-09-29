import Foundation
import UIKit
import Combine

//MARK: - Home View Model

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
                if subject === self.moviesItemSubject {
                    self.movies = items
                } else if subject === self.seriesItemSubject {
                    self.series = items
                }
                self.fetchingState = .finished
            case .failure(let error):
                self.fetchingState = .error(error)
            }
        }
    }
}


extension HomeViewModel {
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
}

enum FetchingState: Equatable {
    static func ==(lhs: FetchingState, rhs: FetchingState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.finished, .finished):
            return true
        case (.error(let lhsError), .error(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
    
    case loading
    case finished
    case error(Error)
}
