import Foundation

struct MoviesResponse: Decodable {
    let result: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case result = "results"
    }
}

struct Movie: Decodable {
    let id: Int
    let mediaType: String?
    let originalName: String?
    let originalTitle: String?
    let posterPath: String?
    let overview: String?
    let voteCount: Int
    let releaseDate: String?
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case mediaType = "media_type"
        case originalName = "original_name"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case overview = "overview"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
