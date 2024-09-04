import Foundation

protocol DataParser {
    func parse<T: Decodable>(_ data: Data, as type: T.Type) throws -> T
}

class JSONDataParser: DataParser {
    func parse<T: Decodable>(_ data: Data, as type: T.Type) throws -> T {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
