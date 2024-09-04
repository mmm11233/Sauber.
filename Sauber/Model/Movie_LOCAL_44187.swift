import Foundation

struct MoviesResponse: Decodable {
    let results: [Movie]  
}

struct Movie: Decodable {
    let id: Int
    let originalLanguage: String?
    let originalName: String?
    let overview: String?
    let popularity: Double
    let posterPath: String?
//    let firstAirDate: Date
    let name: String?
    let voteCount: Int
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
//        case firstAirDate = "first_air_date"
        case name = "name"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
    }
}
