import SwiftUI
import Combine

struct HomeView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: HomeViewModel
    private var cancellables = Set<AnyCancellable>()
    private var gridItems: [GridItem] {
        [GridItem(.fixed(200), spacing: 16)]
    }
    
    // MARK: - Int
    
    public init(
        viewModel: HomeViewModel
    ) {
        self.viewModel = viewModel
        self.viewModel.moviesItems
            .sink { movies in
                viewModel.movies = movies
            }
            .store(in: &cancellables)
        
        self.viewModel.seriesItems
            .sink { series in
                viewModel.series = series
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Body
    
    var body: some View {
        List {
            Section(header: section(title: "Movies", action: {
                print("See all Movies tapped")
            })) {
                moviesGridView
            }
            Section(header: section(title: "Series", action: {
                print("See all Series tapped")
            })) {
                seriesGridView
            }
        }
    }
    // MARK: - Views
    
    private var moviesGridView: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: gridItems, spacing: 16){
                ForEach(viewModel.movies) { result in
                    VStack{
                        AsyncImage(url: URL(string: "\(EndpointRepository.imageBaseURL)\(result.posterPath ?? "")")) {image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 140)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(result.originalTitle ?? "")
                            .font(.headline)
                            .frame(width: 100)
                            .lineLimit(1)
                    
                    }
                    .padding(.horizontal, 8)
                }
            }
            .frame(height: 200)
        }
    }
    
    private var seriesGridView: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: gridItems, spacing: 16) {
                ForEach(viewModel.series) { result in
                    VStack {
                        AsyncImage(url: URL(string: "\(EndpointRepository.imageBaseURL)\(result.posterPath ?? "")")) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 140)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(result.originalName ?? "")
                            .font(.headline)
                            .frame(width: 100)
                            .lineLimit(1)
                    }
                    .padding(.horizontal, 8)
                }
            }
            .frame(height: 200)
        }
    }
    
    // MARK: - Functions
    private func section(title: String, action: @escaping() -> Void) -> some View {
        HStack{
            Text(title)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
                .fontWeight(.bold)
            Spacer()
            Button(action: action) {
                Text("See all").underline()
            }
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.black)
        }
    }
}
