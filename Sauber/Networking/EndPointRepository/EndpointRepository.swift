import Foundation

struct EndpointRepository {
    // MARK: - BaseURL
    
    private static var apiKey = "5640b394ad4d380d373cddff07791a1c"
    private static let host = "https://api.themoviedb.org/3"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    private static let page = "page="
    
    // MARK: - Endpoints
    
    static var topRatedEndpoint: String {
        "\(host)/trending/movie/day?api_key=\(apiKey)&\(page)"
    }
    
    static var popularEndpoint: String {
        "\(host)/tv/popular?api_key=\(apiKey)&\(page)"
    }

}
