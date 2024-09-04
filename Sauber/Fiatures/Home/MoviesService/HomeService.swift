import Foundation
 
final class HomeService {
    private let networkmanager: NetworkManager

     init(
        networkmanager: NetworkManager
     ) {
        self.networkmanager = networkmanager
    }

//    func fetchmovies() {
//        networkmanager.fetchData(from: EndpointRepository.topRatedEndpoint) { [weak self]  in
//            <#code#>
//        }
//    }
}

