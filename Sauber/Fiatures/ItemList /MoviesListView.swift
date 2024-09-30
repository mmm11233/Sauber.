import SwiftUI

struct MoviesListView: View {
    // MARK: - Properties
    
    @ObservedObject var viewModel: MoviesListViewModel
    
    // MARK: - Int
    
    public init(
        viewModel: MoviesListViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            List(viewModel.items) { movie in
                NavigationLink(destination: DetailsView(movie: movie)) {
                    movieListItem(movie: movie)
                        .frame(minHeight: 160)
                        .onAppear {
                            if movie.id == viewModel.items.last?.id {
                                viewModel.refreshData()
                            }
                        }
                }
            }
            
            if viewModel.fetchingState == .loading {
                ProgressView()
                    .frame(height: 50)
            }
        }
        .navigationTitle("Movies List")
    }
    
    private func movieListItem(movie: ItemModel) -> some View {
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
    }
}
