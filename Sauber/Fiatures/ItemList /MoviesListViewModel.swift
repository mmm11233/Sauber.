import UIKit
import Combine

final class MoviesListViewModel {
    
    private let isLoadingSubject: CurrentValueSubject<Bool, Never> = .init(false)
    var isLoading: AnyPublisher<Bool, Never> { isLoadingSubject.eraseToAnyPublisher() }
    
    private let moviesDidLoadSubject: PassthroughSubject<Void, Never> = .init()
    var moviesDidLoadPublisher: AnyPublisher<Void, Never> { moviesDidLoadSubject.eraseToAnyPublisher() }
    
    var recivedMovies: [Movie]
    var currentSection: TableViewSection = .movies
    var currentPage = 1
    var totalPages = 5
    
    init(
        passedMovie: [Movie]
    ) {
        recivedMovies = passedMovie
    }
    
    func refreshData(for section: TableViewSection) {
        switch section {
        case .movies:
            fetchMovies()
        case .serials:
            fetchSerials()
        }
        currentPage += 1
    }
    
    func fetchMovies() {
        isLoadingSubject.send(true)
        
        Services(networkmanager: NetworkManager()).fetchMovies(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            
            self.isLoadingSubject.send(false)
            
            switch result {
            case .success(let model):
                self.recivedMovies.append(contentsOf: model.results)
                self.moviesDidLoadSubject.send()
            case .failure(let error):
                print("Error fetching movies: \(error)")
            }
        }
    }
    
    func fetchSerials() {
        isLoadingSubject.send(true)
        
        Services(networkmanager: NetworkManager()).fetchSerials(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            
            self.isLoadingSubject.send(false)
            
            switch result {
            case .success(let model):
                self.recivedMovies.append(contentsOf: model.results)
                self.moviesDidLoadSubject.send()
            case .failure(let error):
                print("Error fetching movies: \(error)")
            }
        }
    }
}
