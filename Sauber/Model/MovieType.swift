import Foundation

// MARK: - MovieType

public enum MovieType: Int {
    case movies = 0
    case series = 1
    
    var title: String {
        switch self {
        case .movies:
            "Movies"
        case .series:
            "TV Series"
        }
        return ""
    }
}
