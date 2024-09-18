import Foundation

struct EndpointRepository {
    // MARK: - BaseURL
    
    private static var apiKey = "5640b394ad4d380d373cddff07791a1c"
    private static let host = "https://api.themoviedb.org/3"
    private static let page = "&page="
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
    // MARK: - Endpoints
    
    static var topRetedMovies: String {
        "\(host)/trending/movie/day?api_key=\(apiKey)\(page)"
    }
    
    static var popularTvSeries: String {
        "\(host)/tv/popular?api_key=\(apiKey)\(page)"
    }
}
