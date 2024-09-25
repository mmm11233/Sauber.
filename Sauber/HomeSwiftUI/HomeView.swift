import SwiftUI
import Combine

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    private var cancellables = Set<AnyCancellable>()
    
    public init(
        viewModel: HomeViewModel
    ) {
        self.viewModel = viewModel
        self.viewModel.moviesItems
            .sink { movies in
                viewModel.movies = movies
            }
            .store(in: &cancellables)
    }
    
    private var items: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
    }
    
    let rows = [
        GridItem(.fixed(50))
    ]
    
    var body: some View {
        VStack(){
            HStack(alignment: .top, spacing: 180) {
                Text("Movies")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                Button(action: {}) {Text("See all").underline()}
                    .font(.system(size: 20, weight: .bold)).foregroundColor(.black)
                    .padding(.top, 6)
            }
           
            moviesGridView
        }
        .padding(.top, 10)
    }
    
    
    private var moviesGridView: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 0){
                ForEach(viewModel.movies) { result in
                    VStack{
                        AsyncImage(url: URL(string: "\(EndpointRepository.imageBaseURL)\(result.posterPath ?? "")")) {image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(result.originalTitle ?? "")
                            .font(.headline)
                    }
                    .frame(width: 200)
                }
            }
            .padding(.top, 10)
        }
        .padding(.top, 10)
    }
}
