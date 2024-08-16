import Foundation

struct EndpointRepository {
    // MARK: - BaseURL
    
    private let host = "https://api.themoviedb.org/3"
    private let APIKey = "?api_key=5640b394ad4d380d373cddff07791a1c"

    // MARK: - Endpoints
    
    var topRatedEndpoint: String {
        "\(host)/tv/top_rated"
    }
    
    var popularEndpoint: String {
        "\(host)/tv/popular"
    }
}
