import Foundation

struct EndpointRepository {
    // MARK: - BaseURL
    private static var apiKey = "5640b394ad4d380d373cddff07791a1c"
    
    private static let host = "https://api.themoviedb.org/3"
    
    // MARK: - Endpoints
    
    static var topRatedEndpoint: String {
        "\(host)/tv/top_rated?api_key=\(apiKey)"
    }
    
    static var popularEndpoint: String {
        "\(host)/tv/popular"
    }
}
