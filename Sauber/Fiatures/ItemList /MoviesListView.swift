import SwiftUI

struct MoviesListView: View {
    let movies: [ItemModel]
    
    var body: some View {
        NavigationView {
            List(movies) { movie in
                HStack() {
                    AsyncImage(url: URL(string: "\(EndpointRepository.imageBaseURL)\(movie.posterPath ?? "")")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 140)
                    } placeholder: {
                        ProgressView()
                    }
                    VStack( spacing: 4) {
                        Text(movie.originalTitle ?? "")
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .bottomLeading)
                            .lineLimit(1)
                        Text("Rating - \(movie.popularity)")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(3)
                        Text(movie.overview ?? "")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(3)
                    }
                }
                .frame(height: 160)
            }
        }
        .navigationTitle(Text("List"))
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.large)
    }
}
