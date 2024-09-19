import Foundation

struct MoviesResponse: Decodable {
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

struct Movie: Decodable {
    let id: Int
    let originalLanguage: String?
    let originalName: String?
    let overview: String?
    let popularity: Double
    let posterPath: String?
    let name: String?
    let voteCount: Int
    let mediaType: String?
    let originalTitle: String?
    let releaseDate: String?
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case name = "name"
        case voteCount = "vote_count"
        case mediaType = "media_type"
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
