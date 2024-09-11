import Foundation
 
final class Services {
    private let networkmanager: NetworkManager
    private var movieResponse: MoviesResponse?
    
    init(
        networkmanager: NetworkManager
    ) {
        self.networkmanager = networkmanager
    }
    
    func fetchMovies() {
        if let url = URL(string: EndpointRepository.topRatedEndpoint) {
            
            networkmanager.fetchData(from: url) { [weak self] (result: Result<MoviesResponse, Error>) in
                guard let self else { return }
                switch result {
                case .success(let model):
                    self.movieResponse = model
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }
        }
    }
    
    func fetchPopularMovies() {
        if let url = URL(string: EndpointRepository.popularEndpoint) {
            
            networkmanager.fetchData(from: url) { [weak self] (result: Result<MoviesResponse, Error>) in
                guard let self else { return }
                switch result {
                case .success(let model):
                    self.movieResponse = model
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }
        }
    }
}
