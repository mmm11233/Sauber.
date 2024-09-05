import Foundation

struct MoviesResponse: Decodable {
<<<<<<< HEAD
    let results: [Movie]  
=======
    let result: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case result = "results"
    }
>>>>>>> main
}

struct Movie: Decodable {
    let id: Int
<<<<<<< HEAD
    let originalLanguage: String?
    let originalName: String?
    let overview: String?
    let popularity: Double
    let posterPath: String?
//    let firstAirDate: Date
    let name: String?
    let voteCount: Int
=======
    let mediaType: String?
    let originalName: String?
    let originalTitle: String?
    let posterPath: String?
    let overview: String?
    let voteCount: Int
    let releaseDate: String?
>>>>>>> main
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
<<<<<<< HEAD
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
//        case firstAirDate = "first_air_date"
        case name = "name"
        case voteCount = "vote_count"
=======
        case mediaType = "media_type"
        case originalName = "original_name"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case overview = "overview"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
>>>>>>> main
        case voteAverage = "vote_average"
    }
}
