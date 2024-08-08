import Foundation

struct EndpointRepository {
    // MARK: - BaseURL
    
    private let host = "https://api.themoviedb.org/3"
    
    // MARK: - Endpoints
    
    var topRatedEndpoint: String {
        "\(host)/tv/top_rated"
    }
    
    var popularEndpoint: String {
        "\(host)/tv/popular"
    }
}
