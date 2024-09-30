import SwiftUI
import Combine

struct HomeView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: HomeViewModel
    private var gridItems: [GridItem] {
        [GridItem(.adaptive(minimum: 100), spacing: 16)]
    }
    
    // MARK: - Int
    
    public init(
        viewModel: HomeViewModel
    ) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: section(title: "Movies",
                                        destination: MoviesListFactory.makeView(items: viewModel.movies, type: .movies)
                                       ))
                
                 {
                    moviesGridView
                }
                
                Section(header: section(title: "Series",
                                        destination: MoviesListFactory.makeView(items: viewModel.series, type: .series)
                                       ))
                 {
                    seriesGridView
                }
            }
            .padding(.top, -60)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Home")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                }
            }
        }
    }
    
    // MARK: - Views
    
    private var moviesGridView: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: gridItems, spacing: 10) {
                ForEach(viewModel.movies) { result in
                    NavigationLink(destination: DetailsView(movie: result)) {
                        VStack {
                            AsyncImage(url: URL(string: "\(EndpointRepository.imageBaseURL)\(result.posterPath ?? "")")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 130)
                            } placeholder: {
                                ProgressView()
                            }
                            Text(result.originalTitle ?? "")
                                .font(.headline)
                                .foregroundColor(Color.black)
                                .frame(width: 100)
                                .lineLimit(1)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal, 8)
                    }
                }
            }
            .frame(height: 200)
        }
    }
    
    private var seriesGridView: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: gridItems, spacing: 16) {
                ForEach(viewModel.series) { result in
                    NavigationLink(destination: DetailsView(movie: result)) {
                        VStack {
                            AsyncImage(url: URL(string: "\(EndpointRepository.imageBaseURL)\(result.posterPath ?? "")")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 130)
                            } placeholder: {
                                ProgressView()
                            }
                            Text(result.originalName ?? "")
                                .font(.headline)
                                .lineLimit(1)
                                .foregroundColor(Color.black)
                                .frame(width: 100)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal, 8)
                    }
                }
            }
            .frame(height: 200)
        }
    }
    
    // MARK: - Functions
    private func section(title: String, destination: some View) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.black)
                .fontWeight(.medium)
            Spacer()
            NavigationLink(destination: destination) {
                Text("See all").underline()
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
            }
        }
    }
}
