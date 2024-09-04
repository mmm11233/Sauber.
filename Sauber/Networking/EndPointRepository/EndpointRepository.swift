import Foundation

struct EndpointRepository {
    // MARK: - BaseURL
<<<<<<< HEAD
    private static var apiKey = "5640b394ad4d380d373cddff07791a1c"
    
    private static let host = "https://api.themoviedb.org/3"
    
    // MARK: - Endpoints
    
    static var topRatedEndpoint: String {
        "\(host)/tv/top_rated?api_key=\(apiKey)"
    }
    
    static var popularEndpoint: String {
=======
    
    private let host = "https://api.themoviedb.org/3"
    private let APIKey = "?api_key=5640b394ad4d380d373cddff07791a1c"

    // MARK: - Endpoints
    
    var topRatedEndpoint: String {
        "\(host)/tv/top_rated"
    }
    
    var popularEndpoint: String {
>>>>>>> main
        "\(host)/tv/popular"
    }
}
