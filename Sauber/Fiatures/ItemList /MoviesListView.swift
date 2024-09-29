import SwiftUI

struct MoviesListView: View {
    let movies: [ItemModel]
    
    var body: some View {
        NavigationStack {
            List(movies) { movie in
                NavigationLink(destination: DetailsView(movie: movie)) {
                    HStack {
                        AsyncImage(url: URL(string: "\(EndpointRepository.imageBaseURL)\(movie.posterPath ?? "")")) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 140)
                        } placeholder: {
                            ProgressView()
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            Text(movie.originalTitle ?? "Unknown Title")
                                .font(.headline)
                                .lineLimit(1)
                            Text("Rating - \(Int(movie.popularity))")
                                .font(.subheadline)
                                .lineLimit(1)
                            Text(movie.overview ?? "No Overview Available")
                                .font(.body)
                                .lineLimit(3)
                        }
                    }
                    .frame(minHeight: 160)
                }
            }
            .navigationTitle("Movies List")
        }
    }
}
